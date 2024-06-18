<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.do">
                <div class="sidebar-brand-icon">
                    <img style="width: 42px;" src="/olympic/img/olympic.png">
                </div>
                <div class="sidebar-brand-text mx-3">Olympic Admin</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="index.do">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

           

            <!-- Heading -->
            <div class="sidebar-heading">
                Administration
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Pages</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Login Screens:</h6>
                        <a class="collapse-item" href="/olympic/admin/login.do">Login</a>
                        <a class="collapse-item" href="/olympic/admin/index.do">Member</a>
                        <a class="collapse-item" href="#" data-toggle="collapse" data-target="#collapseGame"
			               aria-expanded="true" aria-controls="collapseGame">Game</a>
			            <div id="collapseGame" class="collapse" aria-labelledby="headingGame" data-parent="#collapsePages">
			                <div class="bg-light py-2 collapse-inner rounded">
			                    <a class="collapse-item" href="/olympic/admin/game/index.do">Game</a>
			                    <a class="collapse-item" href="/olympic/admin/game/stadium/index.do">Stadium</a>
			                    <a class="collapse-item" href="/olympic/admin/game/sport/index.do">Sport</a>
			                    <a class="collapse-item" href="/olympic/admin/game/item/index.do">Item</a>
			                </div>
			            </div>
                        <a class="collapse-item" href="/olympic/qna/index.do">QnA</a>
                        <a class="collapse-item" href="/olympic/member/logout.do">Logout</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Charts -->
            <li class="nav-item">
                <a class="nav-link" href="charts.html">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>Charts</span></a>
            </li>

            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link" href="/olympic/index.do">
                    <i class="fas fa-solid fa-house-user"></i>
                    <span>Olympic page</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->