refresh(1, 3);

function refresh(page, pagesize) {
    var title=$("#title").val();
    $.ajax({
        url: "article/list",
        data: {
            "page": page,
            "pagesize": pagesize,
            "title":title
        },
        type: "get",
        dataType: "json",
        success: function (data) {
            var html = '';

            $.each(data.list, function (i, n) {
                html += '<tr id="tableid'+n.aid+'">';
                html += '  <td><input type="checkbox" class="input-control" name="checkbox" value="' + n.aid + '" /></td>';
                html += '  <td class="article-title">' + n.title + '</td>';
                html += '  <td>' + n.cid + '</td>';
                html += '  <td class="hidden-sm">' + n.tagNames + '</td>';
                html += '  <td class="hidden-sm">' + n.thumbsUp + '</td>';
                html += '  <td>' + n.create_time + '</td>';
                html += '  <td>';
                html += '    <a href="toView/workbench/article/updateArticle?aid='+n.aid+'">修改</a> <a href="javascript:void(0)" onclick="deleteArticle('+n.aid+')">删除</a>&nbsp;';
                html += '    <input type="radio" name="isOpen+' + n.aid + '" value="0" onclick="isOpen('+n.aid+',0)"' + (n.isOpen == 0 ? "checked" : "") + '/>公开 <input type="radio" name="isOpen+' + n.aid + '" value="1" onclick="isOpen('+n.aid+',1)" ' + (n.isOpen == 1 ? "checked" : "") + ' />私密';
                html += '  </td>';
                html += '</tr>';
            })
            $("#articleBody").html(html)
            $("#activityPage").bs_pagination({
                currentPage: data.pageNum, // 页码
                rowsPerPage: data.pageSize, // 每页显示的记录条数
                maxRowsPerPage: 20, // 每页最多显示的记录条数
                totalPages: data.pages, // 总页数
                totalRows: data.total, // 总记录条数
                visiblePageLinks: 3, // 显示几个卡片
                showGoToPage: true,
                showRowsPerPage: true,
                showRowsInfo: true,
                showRowsDefaultInfo: true,
                //回调函数，用户每次点击分页插件进行翻页的时候就会触发该函数
                onChangePage: function (event, obj) {
                    //currentPage:当前页码 rowsPerPage:每页记录数
                    refresh(obj.currentPage, obj.rowsPerPage);
                }
            });

        }
    })
}
$("#search").click(function () {
    refresh(1, 3);
})
function isOpen(a,b) {
    $.ajax({
        url:"article/isOpen",
        data:{
            "aid":a,
            "isOpen":b
        },
        type: "post",
        dataType: "json",
        success:function (data) {
            if(!data.ok){
                alert(data.mess)
            }else {
                alert("更新成功")
            }
        }
    })
}
function deleteArticle(aid) {
    $.ajax({
        url:"article/deleteArticle",
        data:{
            "aid":aid
        },
        type: "POST",
        dataType: "json",
        success:function (data) {
            if(data.ok){
                layer.alert(data.mess,{icon:6})
                $("#tableid"+aid).remove();
            }else {
                layer.alert(data.mess,{icon:6})
            }
        }
    })
}