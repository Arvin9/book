<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta name="baidu-site-verification" content="MC7PcVsXl7" />
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<jsp:include page="include/header.jsp" />


<!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style type="text/css">
.error {
	color: red;
}
</style>
</head>
<body>
<div id="wrapper">

		<jsp:include page="include/nav.jsp" />

		<div id="page-wrapper">
		<c:if test="${not empty success}">
			<div class="alert alert-success">
				<button data-dismiss="alert" class="close">×</button>${success}</div>
		</c:if>
		<c:if test="${not empty error}">
			<div class="alert alert-danger">
				<button data-dismiss="alert" class="close">×</button>${error}</div>
		</c:if>
			<div id="tb">
				<button id="add" type="button" class="btn btn-default btn-xs" ><span  class="glyphicon glyphicon-plus" ></span> 新增 </button>
				<button id="updateBtn" type="button" class="btn btn-default btn-xs" ><span  class="glyphicon glyphicon-pencil" ></span> 修改 </button>
				<button id="removeBtn" type="button" class="btn btn-default btn-xs" ><span  class="glyphicon glyphicon-minus" ></span> 删除 </button>
				<button id="addBatch" type="button" class="btn btn-default btn-xs" ><span  class="glyphicon glyphicon-plus" ></span> 批量新增 </button>
			</div>				
			<div class="row">
			<div class="col-md-12">
				<table id="table_id" class="table table-striped  table-hover"  data-height="400" 
				 data-click-to-select="true" data-select-item-name="radioName">
		        </table>
			</div>
			</div>
			  <div id="wrapOfAddBatch">
			  	<form id="formBatch" method="post" action="addBatchItem" role="form" enctype="multipart/form-data" >
			  	   <div class="form-group"  id="uploadBookBatchDiv">
				        <div class="input-group">
				          <label class="input-group-addon" for="uploadBookBatch">批量导入图书文件</label>
				          <input type="file" class="form-control" name="uploadBookBatch" required="required"
				           id="uploadBookBatch">
				        </div>
			        </div>
			        
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<a onclick="Item.uploading()" class="btn btn-primary">提交</a>
			  	</form>
			  </div>
			  
	          <div id="wrap">
			      <form id="form" method="post" action="addItem" role="form" enctype="multipart/form-data" >
			        <div class="form-group" hidden="hidden">
				        <div class="input-group">
				          <label class="input-group-addon" for="bookID">图书ID</label>
				          <input type="text" class="form-control" name="bookID"
				           readonly="readonly">
				        </div>
			        </div>
			        <div class="form-group">
				        <div class="input-group">
				          <label class="input-group-addon" for="serialNumber">编号</label>
				          <input type="text" class="form-control" name="serialNumber"
				           id="serialNumber" required="required">
				        </div>
			        </div>
			        <div class="form-group">
				        <div class="input-group">
				          <label class="input-group-addon" for="bookName">书名</label>
				          <input type="text" class="form-control" name="bookName"
				           id="bookName" required="required">
				        </div>
			        </div>

			        <div class="form-group">
				        <div class="input-group">
				          <label class="input-group-addon" for="bookAuthor">作者</label>
				          <input type="text" class="form-control" name="bookAuthor"
				           id="bookAuthor" >
				        </div>
			        </div>
			       
			        <div class="form-group">
				        <div class="input-group">
				          <label class="input-group-addon" for="bookConcern">出版社</label>
				          <input type="text" class="form-control" name="bookConcern" 
				           id="bookConcern">
				        </div>
			        </div>
			        
			        <div class="form-group">
				        <div class="input-group">
				          <label class="input-group-addon" for="bookEdition">版次</label>
				          <input type="text" class="form-control" name="bookEdition" 
				           id="bookEdition">
				        </div>
			        </div>
			        <div class="form-group">
				        <div class="input-group">
				          <label class="input-group-addon" for="bookPrice">定价</label>
				          <input type="text" class="form-control" name="bookPrice" 
				           id="bookPrice">
				        </div>
			        </div>
			        <div class="form-group">
				        <div class="input-group">
				          <label class="input-group-addon" for="bookDesc">描述</label>
				          <input type="text" class="form-control" name="bookDesc" id="bookDesc">
				        </div>
			        </div>
			        			        
			    
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<a onclick="Item.save()" class="btn btn-primary">提交</a>
				</form>
   			 </div>
		</div>
		<!-- /#page-wrapper -->

	</div>


	<jsp:include page="include/footer.jsp" />
	<script type="text/javascript">
		$(function(){
			Item.init();
			 $('#table_id').bootstrapTable({
	                method: 'get',
	                url: '${ctx}/bookQueryByParam',
	                cache: false,
	                height: 600,
	                striped: true,
	                pagination: true,
	                pageSize: 20,
	                pageList: [5,10, 25, 50, 100, 200],
	                showExport: true,
	                exportDataType:'all',
	                exportTypes:['json', 'xml', 'csv', 'txt', 'sql', 'excel'],
	                contentType: "application/x-www-form-urlencoded",
	                search: true,
	                showColumns: true,
	                showRefresh: true,
	                minimumCountColumns: 2,
	                clickToSelect: true,
	                toolbar : '#tb',
	                singleSelect : false,
	                columns: [{
	                    field: 'state',
	                    checkbox: true
	                },{
	                    field: 'bookID',
	                    title: 'ID',
	                    align: 'center',
	                    valign: 'middle',
	                    sortable : true,
	                    visible : false
	                    
	                }, {
	                    field: 'serialNumber',
	                    title: '编号',
	                    align: 'center',
	                    valign: 'middle',
	                    sortable : true,
	                    visible : true
	                }, {
	                    field: 'bookName',
	                    title: '书名',
	                    align: 'center',
	                    valign: 'middle',
	                    sortable : true,
	                    visible : true
	                }, {
	                    field: 'bookAuthor',
	                    title: '作者',
	                    align: 'center',
	                    valign: 'middle',
	                    sortable : true,
	                    visible : true
	                }, {
	                    field: 'bookConcern',
	                    title: '出版社',
	                    align: 'center',
	                    valign: 'middle',
	                    sortable : true,
	                    visible : true
	                }, {
	                    field: 'bookEdition',
	                    title: '版次',
	                    align: 'center',
	                    valign: 'middle',
	                    sortable : true,
	                    visible : true
	                }, {
	                    field: 'bookPrice',
	                    title: '定价',
	                    align: 'center',
	                    valign: 'middle',
	                    sortable : true,
	                    visible : false
	                }, {
	                    field: 'bookDesc',
	                    title: '备注',
	                    align: 'center',
	                    valign: 'middle',
	                    sortable : true,
	                    visible : false
	                }]
	            });
		});
		
		var Item = {
				commitUrl : '',
				init : function() {
					$("#wrap").dialog({title:"操作",autoOpen: false});
					$("#wrapOfAddBatch").dialog({title:"操作",autoOpen: false});
					
					$('#add').click (function(){
						$("#wrap").dialog({title:"新增",autoOpen: false});
						Item.commitUrl = '${ctx}/addBook';
						$('#form').form("clear");											
						$('#id').hide();
						$("#wrap").dialog("open");
					});
					$('#addBatch').click (function(){
						$("#file").attr("required","required");
						$("#wrapOfAddBatch").dialog({title:"批量新增",autoOpen: false});
						Item.commitUrl = '${ctx}/addBookBatch';
						$('#formBatch').form("clear");
						$("#wrapOfAddBatch").dialog("open");
					});
					$('#updateBtn').click (function(){
						
						$("#file").removeAttr("required");
						$("#wrap").dialog({title:"修改",autoOpen: false});
						 var selections = $('#table_id').bootstrapTable('getSelections');
						 if(selections.length==0){
							 $.messager.popup('请选择要修改的记录');
							 return;
						 }
						 var row = selections[0];
						 Item.commitUrl = '${ctx}/updateBook';
						$('#form').form("clear");
						
						$('#bookPicFile').removeAttr("required");
						$('#bookFileOrURL').removeAttr("required");
						
						$('#id').show();
						$('#form').form("load",row);
						$('#bookFileOrURL').val("1");
						 
						var bookImg = $('#bookImg').val();
						$('#img').attr("src","http://"+bookImg);
						
						$("#wrap").dialog("open");
					});
					$('#removeBtn').click (function(){
						$("#file").removeAttr("required");
						$("#wrap").dialog({title:"删除",autoOpen: false});
						 var selections = $('#table_id').bootstrapTable('getSelections');
						 if(selections.length==0){
							 $.messager.popup('请选择要删除的记录');
							 return;
						 }
						 var row = selections[0];
						 Item.commitUrl = '${ctx}/deleteBook';
						$('#form').form("clear");
						
						$('#bookPicFile').removeAttr("required");
						$('#bookFileOrURL').removeAttr("required");
						$('#bookFileOrURL').val("1");
						$('#id').show();
						$('#form').form("load",row);
						$("#wrap").dialog("open");
					});
					
				},
				save : function() {
					$('#form').form({
						url : Item.commitUrl,
						 onSubmit:function(){ 
							 var result = $(this).validate().form();
							 if(!result){
								 return false;
							 }
					        }, 
						success:function(data){ 
							data = JSON.parse(data);
							 $("#wrap").dialog("close");
							if(data.ret =="0"){
								 $('#table_id').bootstrapTable('refresh');
								 $.messager.popup("success!");
							}else{
								$.messager.alert("提示", "failed!");
							}
						} 
					});
					if(!$('#url').val()=='' && !$('#url').val().startsWith('http')){
						$.messager.popup('url必须是http/https开头！');
						return false;
					}
					if(Item.commitUrl=='${ctx}/deleteBook'){
						$.messager.confirm("警告", "确定要删除 吗!", function() {
							$('#form').form('submit');
						});
					}else if(Item.commitUrl=='${ctx}/updateBook'){
						$.messager.confirm("警告", "确定要更新吗!", function() {
							$('#form').form('submit');
						});
					}else{
						$('#form').form('submit');
					}
					
				},
				uploading : function() {
					$('#formBatch').form({
						url : Item.commitUrl,
						 onSubmit:function(){ 
							 var result = $(this).validate().form();
							 if(!result){
								 return false;
							 }
					        }, 
						success:function(data){ 
							data = JSON.parse(data);
							 $("#wrapOfAddBatch").dialog("close");
							if(data.ret =="0"){
								 $('#table_id').bootstrapTable('refresh');
								 $.messager.popup("success!");
							}else{
								$.messager.alert("提示", "failed!");
							}
						} 
					});
				
					$('#formBatch').form('submit');
				}
		}
	</script>	
</body>
</html>