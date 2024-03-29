<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="itheima" uri="http://itheima.com/common/" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() 
	                   + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>客户管理-BootCRM</title>
	<!-- 引入css样式文件 -->
	<!-- Bootstrap Core CSS -->
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" />
	<!-- MetisMenu CSS -->
	<link href="<%=basePath%>css/metisMenu.min.css" rel="stylesheet" />
	<!-- DataTables CSS -->
	<link href="<%=basePath%>css/dataTables.bootstrap.css" rel="stylesheet" />
	<!-- Custom CSS -->
	<link href="<%=basePath%>css/sb-admin-2.css" rel="stylesheet" />
	<!-- Custom Fonts -->
	<link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/boot-crm.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div id="page-wrapper">
		<div class="rows">
			<div class="col-lg-12">
				<h1 class="page-header">客户管理</h1>
			</div>
		</div>
		<div  class="modal fade" id="newCustomerDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div style="background:white;" class="modal-dialog" role="document">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新建客户信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="new_customer_form">
						<div class="form-group">
							<label for="new_customerName" class="col-sm-2 control-label">
								客户名称
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_customerName" placeholder="客户名称" name="cust_name" />
						</div>
						</div>
						<div class="form-group">
							<label for="new_customerFrom" style="float:left;padding:7px 15px 0 27px;">
								客户来源
							</label>
							<div class="col-sm-10">
								<select class="form-control" id="new_customerFrom" name="cust_source">
									<option value="">--请选择--</option>
									<c:forEach items="${fromType }" var="item">
										<option value="${item.dict_id }"
										<c:if test="${item.dict_id == custSource }">selected</c:if>>
										${item.dict_item_name }
										</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="new_custIndustry" style="float:left;padding:7px 15px 0 27px;">
								所属行业
							</label>
							<div class="col-sm-10">
								<select class="form-control" id="new_custIndustry" name="cust_industry">
									<option value="">--请选择--</option>
									<c:forEach items="${industryType }" var="item">
										<option value="${item.dict_id }"
										<c:if test="${item.dict_id == custIndustry }">selected</c:if>>
										${item.dict_item_name }
										</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="new_custLevel" style="float:left;padding:7px 15px 0 27px;">
								客户级别
							</label>
							<div class="col-sm-10">
								<select class="form-control" id="new_custLevel" name="cust_level">
									<option value="">--请选择--</option>
									<c:forEach items="${levelType }" var="item">
										<option value="${item.dict_id }"
										<c:if test="${item.dict_id == custLevel }">selected</c:if>>
										${item.dict_item_name }
										</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="new_linkMan" class="col-sm-2 control-label">
								联系人
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_linkMan" placeholder="联系人" name="cust_linkman" />
						</div>
						</div>
						<div class="form-group">
							<label for="new_phone" class="col-sm-2 control-label">
								固定电话
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_lphone" placeholder="固定电话" name="cust_phone" />
						</div>
						</div>
						<div class="form-group">
							<label for="new_mobile" class="col-sm-2 control-label">
								移动电话
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_mobile" placeholder="移动电话" name="cust_mobile" />
						</div>
						</div>
						<div class="form-group">
							<label for="new_zipcode" class="col-sm-2 control-label">
								邮政编码
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_zipcode" placeholder="邮政编码" name="cust_zipcode" />
						</div>
						</div>
						<div class="form-group">
							<label for="new_address" class="col-sm-2 control-label">
								联系地址
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="new_address" placeholder="联系地址" name="cust_address" />
						</div>
						</div>
					</form>
				</div>
				<div class="modal-ooter">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-default" onclick="createCustomer()">创建客户</button>
				</div>
			</div>
		</div>
		<div  class="modal fade" id="customerEditDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div style="background:white;" class="modal-dialog" role="document">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改客户信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_customer_form">
						<input type="hidden" id="edit_cust_id" name="cust_id" />
						<div class="form-group">
							<label for="edit_customerName" class="col-sm-2 control-label">
								客户名称
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_customerName" placeholder="客户名称" name="cust_name" />
						</div>
						</div>
						<div class="form-group">
							<label for="edit_customerFrom" style="float:left;padding:7px 15px 0 27px;">
								客户来源
							</label>
							<div class="col-sm-10">
								<select class="form-control" id="edit_customerFrom" name="cust_source">
									<option value="">--请选择--</option>
									<c:forEach items="${fromType }" var="item">
										<option value="${item.dict_id }"
										<c:if test="${item.dict_id == custSource }">selected</c:if>>
										${item.dict_item_name }
										</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_custIndustry" style="float:left;padding:7px 15px 0 27px;">
								所属行业
							</label>
							<div class="col-sm-10">
								<select class="form-control" id="edit_custIndustry" name="cust_industry">
									<option value="">--请选择--</option>
									<c:forEach items="${industryType }" var="item">
										<option value="${item.dict_id }"
										<c:if test="${item.dict_id == custIndustry }">selected</c:if>>
										${item.dict_item_name }
										</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_custLevel" style="float:left;padding:7px 15px 0 27px;">
								客户级别
							</label>
							<div class="col-sm-10">
								<select class="form-control" id="edit_custLevel" name="cust_level">
									<option value="">--请选择--</option>
									<c:forEach items="${levelType }" var="item">
										<option value="${item.dict_id }"
										<c:if test="${item.dict_id == custLevel }">selected</c:if>>
										${item.dict_item_name }
										</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_linkMan" class="col-sm-2 control-label">
								联系人
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_linkMan" placeholder="联系人" name="cust_linkman" />
						</div>
						</div>
						<div class="form-group">
							<label for="edit_phone" class="col-sm-2 control-label">
								固定电话
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_phone" placeholder="固定电话" name="cust_phone" />
						</div>
						</div>
						<div class="form-group">
							<label for="edit_mobile" class="col-sm-2 control-label">
								移动电话
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_mobile" placeholder="移动电话" name="cust_mobile" />
						</div>
						</div>
						<div class="form-group">
							<label for="edit_zipcode" class="col-sm-2 control-label">
								邮政编码
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_zipcode" placeholder="邮政编码" name="cust_zipcode" />
						</div>
						</div>
						<div class="form-group">
							<label for="edit_address" class="col-sm-2 control-label">
								联系地址
							</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_address" placeholder="联系地址" name="cust_address" />
						</div>
						</div>
					</form>
				</div>
				<div class="modal-ooter">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-default" onclick="updateCustomer()">保存修改</button>
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
				<form action="${pageContext.request.contextPath }/customer/list.action" class="form-inline" method="get">
					<div class="form-group">
						<label for="customerName">客户名称</label>
						<input type="text" class="form-control" id="customerName" value="${custName }" name="custName" />
					</div>
					<div class="form-group">
						<label for="customerFrom">客户来源</label> 
						<select	class="form-control" id="customerFrom" name="custSource">
							<option value="">--请选择--</option>
							<c:forEach items="${fromType}" var="item">
								<option value="${item.dict_id}"
								       <c:if test="${item.dict_id == custSource}">selected</c:if>>
								    ${item.dict_item_name }
								</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="custIndustry">所属行业</label>
						<select class="form-control" id="custIndustry" name="custIndustry">
							<option value="">--请选择--</option>
							<c:forEach items="${industryType }" var="item">
								<option value="${item.dict_id }"
									<c:if test="${item.dict_id == custIndustry }">selected</c:if>>
									${item.dict_item_name }
								</option>	
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="custLevel">客户级别</label>
						<select class="form-control" id="custLevel" name="custLevel">
							<option value="">--请选择--</option>
							<c:forEach items="${levelType }" var="item">
								<option value="${item.dict_id }"
									<c:if test="${item.dict_id == custLevel }">selected</c:if>>
									${item.dict_item_name }
								</option>	
							</c:forEach>
						</select>
					</div>
					<button type="submit" class="btn btn-primary">查询</button>
				</form>
			</div>
		</div>
		<a href = "#" class="btn btn-primary" data-toggle="modal" data-target="#newCustomerDialog" onclick="clearCustomer()">新建</a>
		<div class="rows">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">客户信息列表</div>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>编号</th>
								<th>客户名称</th>
								<th>客户来源</th>
								<th>客户所属行业</th>
								<th>客户级别</th>
								<th>固定电话</th>
								<th>手机</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.rows }" var="row">
								<tr>
									<td>${row.cust_id }</td>
									<td>${row.cust_name }</td>
									<td>${row.cust_source }</td>
									<td>${row.cust_industry }</td>
									<td>${row.cust_level }</td>
									<td>${row.cust_phone }</td>
									<td>${row.cust_mobile }</td>
									<td>
										<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#customerEditDialog" onclick="editCustomer(${row.cust_id})">修改</a>
										<a href="#" class="btn btn-primary btn-xs" onclick="deleteCustomer(${row.cust_id})">删除</a>
									</td>	
							</c:forEach>
						</tbody>				
					</table>
					<div class="col-md-12 text-right">
						<itheima:page url="${pageContext.request.contextPath }/customer/list.action" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="<%=basePath%>js/metisMenu.min.js"></script>
<!-- DataTables JavaScript -->
<script src="<%=basePath%>js/jquery.dataTables.min.js"></script>
<script src="<%=basePath%>js/dataTables.bootstrap.min.js"></script>
<!-- Custom Theme JavaScript -->
<script src="<%=basePath%>js/sb-admin-2.js"></script>
	<script type="text/javascript">
//清空新建客户窗口中的数据
	function clearCustomer() {
	    $("#new_customerName").val("");
	    $("#new_customerFrom").val("");
	    $("#new_custIndustry").val("");
	    $("#new_custLevel").val("");
	    $("#new_linkMan").val("");
	    $("#new_phone").val("");
	    $("#new_mobile").val("");
	    $("#new_zipcode").val("");
	    $("#new_address").val("");
	}
	function createCustomer(){
		$.post("<%=basePath%>customer/create.action",
				$("#new_customer_form").serialize(),function(data){
			if(data == "OK"){
				alert("客户创建成功!");
				window.location.reload();
			}else{
				alert("客户创建失败");
				window.location.reload();
			}
		});
	}
	function editCustomer(id){
		$.ajax({
			type:"get",
			url:"<%=basePath%>customer/getCustomerById.action",
			data:{"id" : id},
			success:function(data){
				$("#edit_cust_id").val(data.cust_id);
				$("#edit_customerName").val(data.cust_name);
				$("#edit_customerFrom").val(data.cust_source);
				$("#edit_custIndustry").val(data.cust_industry);
				$("#edit_custLevel").val(data.cust_level);
				$("#edit_linkMan").val(data.cust_linkman);
				$("#edit_phone").val(data.cust_phone);
				$("#edit_mobile").val(data.cust_mobile);
				$("#edit_zipcode").val(data.cust_zipcode);
				$("#edit_address").val(data.cust_address);
			}
			
		});
	}
	function updateCustomer(){
		$.post("<%=basePath%>customer/update.action",
				$("#edit_customer_form").serialize(),function(data){
			if(data == "OK"){
				alert("客户修改成功");
				window.location.reload();
			}else{
				alert("客户修改失败");
				window.location.reload();
			}
		});
	}
	function deleteCustomer(id){
		if(confirm('确实要删除该客户吗')){
			$.post("<%=basePath%>customer/delete.action",
					{"id":id},function(data){
				if(data=="OK"){
					alert("客户删除成功");
					window.location.reload();
				}else{
					aler("删除客户失败");
					window.location.reload();
				}
			});
		}
	}
</script>	
</body>
</html>