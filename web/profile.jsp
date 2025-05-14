<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Course Management System</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        .gradient-text {
            background: linear-gradient(90deg, #3b82f6, #8b5cf6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body class="bg-gray-50">
    <!-- Include Header -->
    <jsp:include page="header.jsp" />

    <!-- Main Content -->
    <main class="pt-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="text-center mb-12">
                <h1 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
                    My <span class="gradient-text">Profile</span>
                </h1>
                <p class="mt-4 text-lg text-gray-600 max-w-3xl mx-auto">
                    Manage your personal information and account settings
                </p>
            </div>
            
            <!-- Success Message -->
            <c:if test="${not empty successMessage}">
                <div class="mb-8 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded shadow-md" role="alert">
                    <p class="font-medium">${successMessage}</p>
                </div>
            </c:if>
            
            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="mb-8 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded shadow-md" role="alert">
                    <p class="font-medium">${errorMessage}</p>
                </div>
            </c:if>
            
            <div class="bg-white shadow-xl rounded-lg overflow-hidden">
                <div class="bg-gradient-to-r from-blue-500 to-indigo-600 px-6 py-16">
                    <div class="flex flex-col items-center">
                        <div class="relative">
                            <img src="https://ui-avatars.com/api/?name=${userProfile.username}&background=random&size=128" alt="Profile" class="w-32 h-32 rounded-full border-4 border-white">
                        </div>
                        <h2 class="mt-4 text-2xl font-bold text-white">${userProfile.username}</h2>
                        <p class="text-blue-100">
                            <c:choose>
                                <c:when test="${userProfile.roleId == 1}">Administrator</c:when>
                                <c:when test="${userProfile.roleId == 2}">Student</c:when>
                                <c:when test="${userProfile.roleId == 3}">Instructor</c:when>
                                <c:otherwise>User</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
                
                <div class="p-6">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <!-- Profile Information -->
                        <div class="md:col-span-2">
                            <h3 class="text-xl font-semibold text-gray-900 mb-4">Profile Information</h3>
                            
                            <form action="profile" method="POST">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                    <div>
                                        <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                                        <input type="text" id="username" value="${userProfile.username}" class="bg-gray-100 w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500" readonly>
                                        <p class="mt-1 text-sm text-gray-500">Username cannot be changed</p>
                                    </div>
                                    
                                    <div>
                                        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                                        <input type="email" id="email" name="email" value="${userProfile.email}" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                    </div>
                                    
                                    <div>
                                        <label for="phoneNumber" class="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
                                        <input type="text" id="phoneNumber" name="phoneNumber" value="${userProfile.phoneNumber}" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                    </div>
                                    
                                    <div>
                                        <label for="gender" class="block text-sm font-medium text-gray-700 mb-1">Gender</label>
                                        <select id="gender" name="gender" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                            <option value="">Select gender</option>
                                            <option value="Male" ${userProfile.gender == 'Male' ? 'selected' : ''}>Male</option>
                                            <option value="Female" ${userProfile.gender == 'Female' ? 'selected' : ''}>Female</option>
                                            <option value="Other" ${userProfile.gender == 'Other' ? 'selected' : ''}>Other</option>
                                        </select>
                                    </div>
                                    
                                    <div>
                                        <label for="dob" class="block text-sm font-medium text-gray-700 mb-1">Date of Birth</label>
                                        <input type="date" id="dob" name="dob" value="<fmt:formatDate value="${userProfile.dob}" pattern="yyyy-MM-dd" />" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                    </div>
                                    
                                    <div>
                                        <label for="studentID" class="block text-sm font-medium text-gray-700 mb-1">Student ID</label>
                                        <input type="text" id="studentID" name="studentID" value="${userProfile.studentID}" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                    </div>
                                </div>
                                
                                <div class="border-t border-gray-200 pt-6 mt-6">
                                    <h4 class="text-lg font-medium text-gray-900 mb-4">Change Password</h4>
                                    
                                    <c:if test="${not empty passwordError}">
                                        <div class="mb-4 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded" role="alert">
                                            <p>${passwordError}</p>
                                        </div>
                                    </c:if>
                                    
                                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                        <div>
                                            <label for="currentPassword" class="block text-sm font-medium text-gray-700 mb-1">Current Password</label>
                                            <input type="password" id="currentPassword" name="currentPassword" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                        </div>
                                        
                                        <div>
                                            <label for="newPassword" class="block text-sm font-medium text-gray-700 mb-1">New Password</label>
                                            <input type="password" id="newPassword" name="newPassword" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                        </div>
                                        
                                        <div>
                                            <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1">Confirm New Password</label>
                                            <input type="password" id="confirmPassword" name="confirmPassword" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                        </div>
                                    </div>
                                    <p class="mt-2 text-sm text-gray-500">Leave password fields empty if you don't want to change your password</p>
                                </div>
                                
                                <div class="mt-8 flex justify-end">
                                    <button type="submit" class="px-6 py-3 bg-blue-600 text-white font-medium rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-300">
                                        Save Changes
                                    </button>
                                </div>
                            </form>
                        </div>
                        
                        <!-- Account Summary -->
                        <div class="bg-gray-50 p-6 rounded-lg">
                            <h3 class="text-xl font-semibold text-gray-900 mb-4">Account Summary</h3>
                            
                            <div class="space-y-4">
                                <div>
                                    <h4 class="text-sm font-medium text-gray-500">Account Type</h4>
                                    <p class="text-base font-medium text-gray-900">
                                        <c:choose>
                                            <c:when test="${userProfile.roleId == 1}">Administrator</c:when>
                                            <c:when test="${userProfile.roleId == 2}">Student</c:when>
                                            <c:when test="${userProfile.roleId == 3}">Instructor</c:when>
                                            <c:otherwise>User</c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                
                                <div>
                                    <h4 class="text-sm font-medium text-gray-500">Enrolled Courses</h4>
                                    <p class="text-base font-medium text-gray-900">
                                        <a href="my-courses" class="text-blue-600 hover:text-blue-800">
                                            View My Courses
                                        </a>
                                    </p>
                                </div>
                                
                                <div class="pt-4 border-t border-gray-200">
                                    <a href="logout" class="inline-flex items-center text-red-600 hover:text-red-800">
                                        <i class="fas fa-sign-out-alt mr-2"></i> Sign Out
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

   
</body>
</html>