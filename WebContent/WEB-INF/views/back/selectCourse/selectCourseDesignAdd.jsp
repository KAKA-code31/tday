<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>添加选课</title>
<%@ include file="/commons/basejs.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" type="text/css" href="${staticPath }/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${staticPath }/static/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${staticPath }/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${staticPath }/static/lib/icheck/icheck.css" />
<link rel="stylesheet" type="text/css" href="${staticPath }/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${staticPath }/static/h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css" href="${staticPath }/static/css/style.css" />
<link rel="stylesheet" type="text/css" href="${staticPath }/static/css/practice.css"/>
</head>
<body  style="min-width: 600px;">
<nav class="breadcrumb">
	<i class="Hui-iconfont" style="color: #000;">&#xe67f;</i> 首页 
	<span class="c-gray en">&gt;</span>课程实验
	<span class="c-gray en">&gt;</span>学生选课
	<span class="c-gray en">&gt;</span>添加选课
</nav>
<article class="page-container">
	<form class="form form-horizontal" id="selectCourseForm">
		<div class="page-container_tittle">
			<i class="firm_det_tit_line"></i>添加选课
		</div>
		<div class="row cl">
			<div class="col-xs-6 col-sm-7">
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>课程名称：</label>
					<div class="formControls col-xs-6 col-sm-5">
						<select class="select"  id="courseId" name ="courseId">
										<option value="">--课程名称--</option>
										<c:forEach var="courseList" items="${courseList}">
											<option value="${courseList.id}">${courseList.code}-${courseList.name}</option>
										</c:forEach>
						</select>
					</div>
				</div><br/>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>题目名称：</label>
					<div class="formControls col-xs-6 col-sm-5">
						<select class="select"  id="experimentId" name ="experimentId">
										<option value="">--题目名称--</option>
						</select>
					</div>
				</div><br/>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>所属院系：</label>
					<div class="formControls col-xs-6 col-sm-5">
						<select class="select"  id="departmentId" name="departmentId">
										<option value="">--所属院系--</option>
										<c:forEach var="delist" items="${departmentList}">
											<option value="${delist.id}">${delist.name}</option>
										</c:forEach>
						</select>
					</div>
				</div><br/>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>所属专业：</label>
					<div class="formControls col-xs-6 col-sm-5">
						<select class="select" id="majorId" name = "majorId">
										<option value="">--所属专业--</option>
						</select>
					</div>
				</div><br/>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>所属班级：</label>
					<div class="formControls col-xs-6 col-sm-5">
						<select class="select" id="classId" name ="classId">
										<option value="">--所属班级--</option>
						</select>
					</div>
				</div>
			</div>
			<div class="col-xs-6 col-sm-5"  style="overflow-y:auto;height:360px;">
				<table
					class="table table-border table-bordered table-bg table-hover table-sort">
					<thead>
						<tr class="text-c">
							<th style="width:60px;">x</th>
							<th>学号</th>
							<th>姓名</th>
						</tr>
					</thead>
					<tbody id="student">
<%-- 						<c:if
							test="${selectCourseList == null or selectCourseList.size() == 0 }">
							<tr>
								<td colspan="8">没有记录</td>
							</tr>
						</c:if> --%>
					</tbody>
				</table>				
			</div>
		</div>
	</form>
</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${staticPath }/static/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${staticPath }/static/lib/layer/2.4/layer.js"></script> 
<script type="text/javascript" src="${staticPath }/static/lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="${staticPath}/static/plugins/validate/jquery.validate.min.js"></script>
<script type="text/javascript" src="${staticPath}/static/plugins/validate/localization/messages_zh.min.js"></script>
<!--/_footer /作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript">
function jumpUrl() {
	layer.closeAll();
}
$("#classId").blur(function(){
	var classId = document.getElementById("classId").value;
	var courseId = document.getElementById("courseId").value;
	$.ajax({
		url:"${staticPath }/back/report/selectStudent",
		type:"post",
		dataType : "json",
		data:{classId:classId,courseId:courseId},
		success:function(data){ 				
				var list='';		
		  		var i=0;
				$.each(data.obj, function(idx,obj) {
				 	list+='<tr class="text-c"><td><input type="checkbox" value="'+obj.id+'" class="ids" name="ids"></td>';
					list+="<td>"+obj.userId+"</td>" ;
					list+="<td>"+obj.name+"</td></tr>" ;
					i++;
				});  
				list+='';
				$("#student").html(list);	  					
		}
	});		
}); 
$("#courseId").blur(function(){
	var courseId = document.getElementById("courseId").value;
	$.ajax({
		url:"${staticPath }/back/report/seletSubject",
		type:"post",
		dataType : "json",
		data:{courseId:courseId},
		success:function(data){
 			var subjects=data.obj;
			if(subjects!=null && subjects.length>0){
				$("#experimentId").empty();
				for(var i=0;i<subjects.length;i++){
					$("#experimentId").append(
						"<option selected='selected' value='"+subjects[i].id+"'>"
					+subjects[i].name+"</option>");
				}
			}else{
				$("#experimentId").empty();//清空
				$("#experimentId").append(
					"<option value=''>--题目名称--</option>"
				);
			} 
		}
	});	
});
$("#departmentId").blur(function(){
	var departmentId = document.getElementById("departmentId").value;
	var courseId = document.getElementById("courseId").value;
	if(courseId!=null&&courseId!=""){
		$.ajax({
			url:"${staticPath }/back/report/seletMajor",
			type:"post",
			dataType : "json",
			data:{departmentId:departmentId},
			success:function(data){
				var types=data.obj;
				if(types!=null && types.length>0){
					$("#majorId").empty();
					for(var i=0;i<types.length;i++){
						$("#majorId").append(
							"<option selected='selected' value='"+types[i].id+"'>"
						+types[i].name+"</option>");
					}
				}else{
					$("#majorId").empty();//清空
					$("#majorId").append(
						"<option value=''>--所属专业--</option>"
					);
				}
			}
		});		
	}else{
		layer.alert("请先选择课程", {icon: 2},function(){location.reload();jumpUrl();});
	}
});
$("#majorId").blur(function(){
	var majorId = document.getElementById("majorId").value;
	$.ajax({
		url:"${staticPath }/back/report/selectStudentClass",
		type:"post",
		dataType : "json",
		data:{majorId:majorId},
		success:function(data){
			var types=data.obj;
			if(types!=null && types.length>0){
				$("#classId").empty();
				for(var i=0;i<types.length;i++){
					$("#classId").append(
						"<option selected='selected' value='"+types[i].id+"'>"
					+types[i].year+'级'+types[i].name+"</option>");
				}
			}else{
				$("#classId").empty();//清空
				$("#classId").append(
					"<option value=''>--所属班级--</option>"
				);
			}
		}
	});
});
$(function(){
 	//校验
	 $("#selectCourseForm").validate({
		rules:{
			'courseId':{
				required:true
			},
			'experimentId':{
				required:true
			},
			'departmentId':{
				required:true
			},
			'majorId':{
				required:true
			},
			'classId':{
				required:true
			}
		},
		messages:{
			'courseId':{
				required:"请选择课程！"
			},
			'experimentId':{
				required:"请选择题目！"
			},
			'departmentId':{
				required:"请选择院系！"
			},
			'majorId':{
				required:"请选择专业！"
			},
			'classId':{
				required:"请选择班级！"
			}
		}
	});
});
	
function getFormData() {	
 	if ($("#selectCourseForm").valid()) {
		var data = $("#selectCourseForm").serialize();
		return data;
	} else {
		return 0;
	} 
}
	
	/* function checkInput(){
		 var code=$("input[name='code']").val();  
		 var name=$("input[name='name']").val();  
	     var patrn=/[`~!@#$%^&*()_+<>?:"{},.\/;'[\]]/im;  
	     if(patrn.test(code)){  
	         top.layer.alert("提示信息：您输入的院系编码含有非法字符！");  
	         $("input[name='code']").val('');  
	         return false;     
	     }     
	     if(patrn.test(name)){  
	         top.layer.alert("提示信息：您输入的院系名称含有非法字符！");  
	         $("input[name='name']").val('');  
	         return false;     
	     }     
	     return true;  
	} */
</script>
</body>
</html>