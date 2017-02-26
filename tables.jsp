<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="entity.Manager"%>
<%@ page import="entity.PageBean"%>
<%@ page import="entity.Fuser"%>
<%@ page import="util.MD5Util"%>
<%@ page import="entity.LogTime"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html class='no-js' lang='en'>
<head>
<meta charset='utf-8'>
<meta content='IE=edge,chrome=1' http-equiv='X-UA-Compatible'>
<title>Tables</title>
<meta content='lab2023' name='author'>
<meta content='' name='description'>
<meta content='' name='keywords'>
<link href="css/application-a07755f5.css"
	rel="stylesheet" type="text/css" />
<link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/admun_style.css">
<link rel="stylesheet" type="text/css" href="css/model.css">
</head>
<%
	Manager manager = (Manager) session.getAttribute("manager");
	int MUindexs = (int) session.getAttribute("MUindexs");
	int MMindexs = (int) session.getAttribute("MMindexs");
  	PageBean pages = (PageBean) session.getAttribute("users");
	PageBean pages2 = (PageBean) session.getAttribute("Managers");
   	List list = pages.getList();
	Iterator iter = list.iterator();
	List<Manager> list2 = pages2.getList();
	Iterator iter2 = list2.iterator();
	List logtimes = (List)session.getAttribute("logtime");
	Iterator  iter3 = logtimes.iterator();
	Random random = new Random();
	int max=100;
    int min=30;
	int s = 30;
   %>
<body class='main page'>
	<!-- Navbar -->
	<div id='wrapper'>
		<!-- Sidebar -->
		<section id='sidebar'>
			<i class='icon-align-justify icon-large' id='toggle'></i>
			<ul id='dock'>
				<li class=' launcher'><i class='icon-dashboard'></i> <a
					href="dashboard.jsp">主页</a></li>
				<li class='launcher'><i class='icon-file-text-alt'></i> <a
					href="work.manager?Windex=1">审核状态</a></li>
				<li class='active launcher'><i class='icon-table'></i> <a
					href="all.manager?MUindex=1&MMindex=1">用户管理</a></li>
				<li class='launcher dropdown hover'><i class='icon-flag'></i> <a
					href='teachAnalysis.manager?TAindex=1'>教程管理</a> <!-- <ul class='dropdown-menu'>
              <li class='dropdown-header'>Launcher description</li>
              <li>
                <a href='#'>Action</a>
              </li>
              <li>
                <a href='#'>Another action</a>
              </li>
              <li>
                <a href='#'>Something else here</a>
              </li>
            </ul> --></li>
				<li class='launcher'><i class='icon-bookmark'></i> <a href='#'>小组管理</a>
				</li>
				<li class='launcher'><i class='icon-cloud'></i> <a
					href='workAnalysis.manager?WAindex=1'>作品管理</a></li>
			</ul>
			<div data-toggle='tooltip' id='beaker' title='Made by lab2023'></div>
		</section>
		<!-- Tools -->
		<section id='tools'>
			<ul class='nav navbar-nav pull-right'>
				<li class='dropdown'><a class='dropdown-toggle'
					data-toggle='dropdown' href='#'> <i class='icon-envelope'></i>
						消息 <span class='badge'>5</span> <b class='caret'></b>
				</a>
					<ul class='dropdown-menu'>
						<li><a href='#'>新消息</a></li>
						<li><a href='#'>收件箱</a></li>
						<li><a href='#'>发件箱</a></li>
						<li><a href='#'>垃圾箱</a></li>
					</ul></li>
				<li><a href='#'> <i class='icon-cog'></i> 设置
				</a></li>
				<li class='dropdown user'><a class='dropdown-toggle'
					data-toggle='dropdown' href='#'> <i class='icon-user'></i> <strong><%=manager.getName() %></strong>
						<b class='caret'></b>
				</a>
					<ul class='dropdown-menu'>
						<li><a href='#'>修改资料</a></li>
						<li class='divider'></li>
						<li><a href="exit.manager">退出</a></li>
					</ul></li>
			</ul>
		</section>
		<!-- Content -->
		<div id='content'>
			<div class='panel panel-default grid'>
				<div class='panel-heading'>
					<i class='icon-table icon-large'></i> 用户管理
					<div class='panel-tools'>
						<div class='btn-group'>
							<a class='btn' href='#'> <i class='icon-wrench'></i> 设置
							</a> <a class='btn' href='#'> <i class='icon-filter'></i> 过滤
							</a> <a class='btn' data-toggle='toolbar-tooltip' href='#'
								title='Reload'> <i class='icon-refresh'></i>
							</a>
						</div>
					</div>
				</div>
				<div class='panel-body filters'>
					<div class='row'>
						<div class='col-md-9'></div>
						<div class='col-md-3'>
							<div class='input-group'>
								<input class='form-control' placeholder='快速查找...' type='text'>
								<span class='input-group-btn'>
									<button class='btn' type='button'>
										<i class='icon-search'></i>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<table class='table'>
					<thead>
						<tr>
							<th>ID</th>
							<th>邮箱</th>
							<th>用户名</th>
							<th>登录时长</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<% 
			while(iter.hasNext()){
				Fuser user = (Fuser)iter.next();
				LogTime logtime = (LogTime)iter3.next();
			    s = random.nextInt(max)%(max-min+1) + min;
			%>
						<tr class="zuopin_form">
							<td><%=user.getId()%></td>
							<td><a
								href="table_detail.manager?userEmail=<%=user.getEmail()%>"><%=user.getEmail()%></a></td>
							<td><%=user.getName()%></td>
							<td><%=s %></td>
							<td class='action'><a class='btn btn-success' href='#'>
									修改 </a> <a class='btn btn-danger'
								href='deleteUser.manager?deleteEmial=<%=user.getEmail()%>'>
									删除 </a></td>
						</tr>
						<%
				}
			  %>
					</tbody>
				</table>
				<div class='panel-footer'>
					<ul class='pagination pagination-sm'>
						<li><a href='#'>«</a></li>
						<% for(int i=1;i<=pages.getPageTotal();i++){%>
						<li <%if(MUindexs==i){%> class='active' <%}%>><a
							href='user.manager?MUindex=<%=i%>'><%=i%></a></li>
						<%}%>
						<li><a href='#'>»</a></li>
					</ul>
					<div class='pull-right'>Showing 1 to 10 of 32 entries</div>
				</div>
			</div>
			<div class='panel panel-default grid'>
				<div class='panel-heading'>
					<i class='icon-table icon-large'></i> 超级管理员
				</div>
				<table class='table'>
					<thead>
						<tr>
							<th>ID</th>
							<th>邮箱</th>
							<th>用户名</th>
							<th>密码</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<% 
			while(iter2.hasNext()){
				Manager user = (Manager)iter2.next();
			%>
						<tr class="zuopin_form">
							<td><%=user.getId()%></td>
							<td><%=user.getEmail()%></td>
							<td><%=user.getName()%></td>
							<td><%=user.getPassword()%></td>
							<td class='action'><a class='btn btn-success' href='#'>
									修改 </a> <a class='btn btn-danger'
								href='deleteManager.manager?deleteEmial=<%=user.getEmail()%>'>
									删除 </a></td>
						</tr>

						<%
				}
			  %>
					</tbody>
				</table>
				<div class='panel-footer'>
					<ul class='pagination pagination-sm'>
						<li><a href='#'>«</a></li>
						<% for(int i=1;i<=pages2.getPageTotal();i++){%>
						<li <%if(MMindexs==i){%> class='active' <%}%>><a
							href='manager.manager?MMindex=<%=i%>'><%=i%></a></li>
						<%}%>
						<li><a href='#'>»</a></li>
					</ul>
					<div class='pull-right'>Showing 1 to 10 of 32 entries</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<!-- Javascripts -->

	<!-- Google Analytics -->
	<div class="model">
		<div class="model_content"></div>
		<div class="model_close">×</div>
	</div>
	<script src="jquery.min.js" type="text/javascript"></script>

</html>

