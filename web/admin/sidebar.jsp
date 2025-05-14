<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="bg-gray-800 text-white w-64 flex-shrink-0 hidden md:block">
    <div class="flex items-center justify-center h-16 border-b border-gray-700">
        <a href="${pageContext.request.contextPath}/home" class="text-xl font-bold">
            Home
        </a>
    </div>
    <nav class="mt-5">
        <div class="px-4 py-2 text-xs text-gray-400 uppercase tracking-wider">
            Main
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" 
           class="flex items-center px-6 py-3 text-gray-300 hover:bg-gray-700 hover:text-white ${pageContext.request.servletPath.endsWith('/dashboard.jsp') ? 'bg-gray-700 text-white' : ''}">
            <i class="fas fa-tachometer-alt w-5 h-5 mr-3"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/courses" 
           class="flex items-center px-6 py-3 text-gray-300 hover:bg-gray-700 hover:text-white ${pageContext.request.servletPath.endsWith('/course-list.jsp') || pageContext.request.servletPath.endsWith('/course-form.jsp') ? 'bg-gray-700 text-white' : ''}">
            <i class="fas fa-book w-5 h-5 mr-3"></i>
            <span>Courses</span>
        </a>

        <a href="${pageContext.request.contextPath}/admin/instructors" 
           class="flex items-center px-6 py-3 text-gray-300 hover:bg-gray-700 hover:text-white ${pageContext.request.servletPath.endsWith('/instructor-list.jsp') ? 'bg-gray-700 text-white' : ''}">
            <i class="fas fa-chalkboard-teacher w-5 h-5 mr-3"></i>

            <span>Instructors</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="flex items-center px-4 py-2 text-gray-600 hover:bg-gray-100 hover:text-blue-600 ${pageContext.request.servletPath.contains('/admin/user') ? 'bg-gray-100 text-blue-600' : ''}">
            <i class="fas fa-users mr-3"></i>
            <span>Manage Users</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/categories" class="flex items-center px-4 py-2 text-gray-600 hover:bg-gray-100 hover:text-blue-600 ${pageContext.request.servletPath.contains('/admin/category') ? 'bg-gray-100 text-blue-600' : ''}">
            <i class="fas fa-tags mr-3"></i>
            <span>Manage Categories</span>
        </a>





        <div class="px-4 py-2 mt-6 text-xs text-gray-400 uppercase tracking-wider">
            Account
        </div>

        <a href="${pageContext.request.contextPath}/logout" 
           class="flex items-center px-6 py-3 text-gray-300 hover:bg-gray-700 hover:text-white">
            <i class="fas fa-sign-out-alt w-5 h-5 mr-3"></i>
            <span>Logout</span>
        </a>
    </nav>
</div>