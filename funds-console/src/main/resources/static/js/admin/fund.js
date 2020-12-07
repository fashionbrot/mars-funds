$(function (){
    loadData();
    setInterval(function() {
        updateGuzhi();
    }, 300000);
})
var dataTable;
function loadData() {
    var tableId = "#dataTableId";
    $(tableId).dataTable().fnDestroy();
    dataTable = $(tableId)
        .on('xhr.dt', function( e, settings, json, xhr ){
            // json.draw = 1;
            //将后台总数，赋值给 分页工具
            if(json.code==0){
                json.recordsTotal = json.data.itotalDisplayRecords;
                json.recordsFiltered = json.data.itotalDisplayRecords;
            }else{
                json.recordsTotal = 0;
                json.recordsFiltered = 0;
            }
        })
        .DataTable({
        ajax : {
            type: "GET",
            url: '/fund/page',
            // 传入已封装的参数
            data: function(data){
                data.page = data.start / data.length + 1;
                data.pageSize = data.length;
                // 右上角搜索
                data.fundCode = $("#query").val();
                delete data.search;
                delete data.columns;
            },
            dataType: "json",
            dataSrc : function(result) {
                if (result.code != 0) {
                    alert("获取数据失败:"+result.msg);
                    return false;
                }
                if (result.data!=null ){
                    return  result.data.data ;
                }
                return [];
            },
            error : function(XMLHttpRequest, textStatus, errorThrown) {
                alert("获取列表失败");
            }
        },
        dom: '<fB<t>ip>',
        stripeClasses: ["odd", "even"],
        paginationType: "full_numbers",
        responsive: true,//自适应
        // 每次对 datatable 进行操作时也是请求后台
        serverSide : true,
        // 加载状态
        processing : true,
        // 默认排序查询,为空则表示取消默认排序否则复选框一列会出现小箭头
        order: [1,2,3],
        // 分页,默认打开
        paging : true,
        // 是否禁用原生搜索
        searching: false,
        orderable: true,
        language : dataTableConfig.DATA_TABLES.DEFAULT_OPTION.LANGUAGE,
        columns : [
            {
                className: "td-checkbox",
                bSortable : false,
                className : "text-center",
                data : "id",
                width : '15px',
                render : function(data, type, row, meta) {
                    var content = '<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">';
                    content += '	<input type="checkbox" name="stuCheckbox" class="group-checkable" value="' + row.fundCode + '" />';
                    content += '	<span></span>';
                    content += '</label>';
                    return content;
                }
            },
            {
                data : 'fundCode',
                bSortable : true,
                // width : "30px",
                className : "text-center",
                render : dataTableConfig.DATA_TABLES.RENDER.ELLIPSIS
            },
             {
                data : 'fundName',
                bSortable : true,
                // width : "30px",
                className : "text-center",
                render : dataTableConfig.DATA_TABLES.RENDER.ELLIPSIS
            }, {
                data : 'operate',
                bSortable : false,
                visible : true,
                // width : '200px',
                render : function(data, type, full) {

                    return "<span class=\"sparkline\" sparkType=\"bar\" sparkBarColor=\"#4FC0E8\" sparkWidth=\"300\" sparkHeight=\"60\" sparkBarWidth=\"20\">5,4,3,2,4,5,6,7,8,6,4,5</span>";
                    //return "<span class=\"sparkline\" sparkFillColor=\"#FFF\" sparkLineWidth=\"2\" sparkLineColor=\"#9FD468\" sparkWidth=\"100\" sparkHeight=\"45\" >5,4,3,2,4,5,6,7,8,6,4,5</span>";

                    /*return '<a class="btn btn-success btn-" onclick="queryByUserId(\'' + full.id + '\')"><i class="fa fa-edit">修改</i> </a>'
                        + '&nbsp;&nbsp;<a class="btn btn-warning btn-circle" onclick="showModal(\'' + full.id + '\')"> <i class="fa fa-times">删除</i></a>';*/
                }
            }
        ],
        drawCallback : function(settings) {
            // 取消全选
            $(":checkbox[name='keeperUserGroup-checkable']").prop('checked', false);
            // 高亮显示当前行
            $(settings.nTable).find("tbody tr").click(function(e) {
                $(e.target).parents('table').find('tr').removeClass('warning');
                $(e.target).parents('tr').addClass('warning');
            });
            uiSparkline();
        }

        //dom:"<'row' <'col-md-12'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>"

    });


    // 如果 scrollX : true 使用这个$('#keeperUserList_wrapper').on("change", ":checkbox", function() {
    // 如果 scrollX : false $('#keeperUserList').on("change", ":checkbox", function() {
    // 因为  scrollX : true 为true加了滚动条，表头和表体成了两个表格，这个可以查看代码就知道
    $(tableId+'_wrapper').on("change", ":checkbox", function() {
        // 列表复选框
        if ($(this).is("[name='topCheckboxName']")) {
            // 全选
            $(":checkbox", '#dataTableId').prop("checked",$(this).prop("checked"));
        }else{
            // 一般复选
            var checkbox = $("tbody :checkbox", '#dataTableId');
            $(":checkbox[name='cb-check-all']", '#dataTableId').prop('checked', checkbox.length == checkbox.filter(':checked').length);
        }
    }).on('preXhr.dt', function(e, settings, data) {
        // ajax 请求之前事件
        data.page = data.start / data.length + 1;
        data.limit = data.length;
        delete data.start;
        delete data.order;
        delete data.search;
        delete data.length;
        delete data.columns;
    });

}

var uiSparkline = function(){

    if($(".sparkline").length > 0)
        $(".sparkline").sparkline('html', { enableTagOptions: true,disableHiddenCheck: true, height: '300', width: '60px'});

}


function addFund() {
    loading();
    var startDate = "2020-06-01";
    $.ajax({
        url: "/fund/build?code="+$("#fundCode").val()+"&startDate="+startDate,
        type: "post",
        data: {},
        dataType: "json",
        success: function (data) {
            loaded();
            if (data.code == "0") {
                loadData();
            } else {
                alert(data.msg);
            }
        },error: function (){
            alert("请求失败");
        }
    });
}

function updateGuzhi() {
    loading();
    $.ajax({
        url: "/fund/updateGuzhi",
        type: "post",
        data: {},
        dataType: "json",
        success: function (data) {
            loaded();
            if (data.code == "0") {
                loadData();
            } else {
                alert(data.msg);
            }
        },error: function (){
            alert("请求失败");
        }
    });
}


function fundhold() {

    var listIds = $("input[name='stuCheckbox']:checked");
    var ids="";
    if (listIds){
        for(var i=0;i<listIds.length;i++){
            if (ids==""){
                ids =$(listIds[i]).val();
            }else{
                ids += ","+$(listIds[i]).val();
            }
        }
    }
    var userName = $("#userName").val();
    console.log(ids);
    if (ids==""){
        alert("请选择要缴费的学员");
        return false;
    }

    loading();
    $.ajax({
        url: "/fund/fundhold",
        type: "post",
        data: {"fundCodes":ids,"userName":userName},
        dataType: "json",
        success: function (data) {
            loaded();
            if (data.code == "0") {
                loadData();
            } else {
                alert(data.msg);
            }
        },error: function (){
            alert("请求失败");
        }
    });
}



function addModal(){
    $('#addModal').modal('show');
}
//添加
var add = function () {
    var a = $("#addForm").serializeJson();
    loading();
    $.ajax({
        url: "../hzzy/certificate/type/insert",
        type: "post",
        data: JSON.stringify(a),
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
            loaded();
            if (data.code == "0") {
                $('#addModal').modal('hide');
                $("input[type=reset]").trigger("click");
                loadData();
            } else {
                alert(data.msg);
            }
        },error: function (){
            alert("请求失败");
        }
    });
}

function showModal(id) {
    $("#delId").val(id);
    $('#delModal').modal('show');
}


var del = function () {
    loading();
    $.ajax({
        url: "../hzzy/certificate/type/deleteById",
        type: "post",
        data: {"id": $("#delId").val()},
        dataType: "json",
        success: function (data) {
            loaded();
            if (data.code == "0") {
                $('#delModal').modal('hide');
                loadData();
            } else {
                alert(data.msg);
            }
        },error: function (){
            alert("请求失败");
        }
    });
}


var edit = function () {
    loading();
    var a = $("#editForm").serializeJson();
    $.ajax({
        url: "../hzzy/certificate/type/updateById",
        type: "post",
        data: JSON.stringify(a),
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
            loaded();
            if (data.code == "0") {
                $('#editModal').modal('hide');
                loadData();
            } else {
                alert(data.msg);
            }
        },error: function (){
            alert("请求失败");
        }
    });
}


var queryByUserId = function (id) {
    loading();
    $.ajax({
        url: "../hzzy/certificate/type/selectById",
        type: "post",
        data: {"id": id},
        dataType: "json",
        success: function (result) {
            loaded();
            if (result.code!=0){
                alert(result.msg);
                return false;
            }
            var data = result.data;
            $("#editId").val(data.id);
            $("#editCertificateName").val(data.certificateName);
            $('#editModal').modal('show');
        },error: function (){
            alert("请求失败");
        }
    });
}



