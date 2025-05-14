<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Users - Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>
    <body class="bg-gray-100">
        <div class="min-h-screen flex">
            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp" />

            <!-- Main Content -->
            <div class="flex-1 flex flex-col overflow-hidden">
                <!-- Top Header -->
                <header class="bg-white shadow-sm z-10">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex justify-between items-center">
                        <h1 class="text-2xl font-semibold text-gray-900">Manage Users</h1>
                    </div>
                </header>

                <!-- Main Content -->
                <main class="flex-1 overflow-y-auto p-4 sm:p-6 lg:p-8">
                    <!-- Status Messages -->
                    <c:if test="${param.message != null}">
                        <div class="mb-4 px-4 py-3 rounded relative
                             ${param.message == 'deleted' ? 'bg-green-100 border border-green-400 text-green-700' : ''}
                             ${param.message == 'error' ? 'bg-red-100 border border-red-400 text-red-700' : ''}
                             ${param.message == 'invalid' ? 'bg-yellow-100 border border-yellow-400 text-yellow-700' : ''}">
                            <span class="block sm:inline">
                                <c:choose>
                                    <c:when test="${param.message == 'deleted'}">
                                        <i class="fas fa-check-circle mr-2"></i>User has been successfully deleted.
                                    </c:when>
                                    <c:when test="${param.message == 'error'}">
                                        <i class="fas fa-exclamation-circle mr-2"></i>An error occurred while deleting the user.
                                    </c:when>
                                    <c:when test="${param.message == 'invalid'}">
                                        <i class="fas fa-exclamation-triangle mr-2"></i>Invalid user ID provided.
                                    </c:when>
                                </c:choose>
                            </span>
                        </div>
                    </c:if>

                    <!-- Users Table -->
                    <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            ID
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Username
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Role
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Email
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Student ID
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:choose>
                                        <c:when test="${not empty users && users.size() > 0}">
                                            <c:forEach items="${users}" var="user">
                                                <tr>
                                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                        ${user.id}
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm font-medium text-gray-900">
                                                            ${user.username}
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                                              ${user.roleId == 1 ? 'bg-purple-100 text-purple-800' : 'bg-green-100 text-green-800'}">
                                                            ${user.role.roleName}
                                                        </span>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                        ${user.email}
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                        ${user.studentID}
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <div class="flex justify-end space-x-2">
                                                            <c:if test="${user.roleId != 1}">
                                                                <a href="#" onclick="confirmDelete(${user.id}, '${user.username}')" 
                                                                   class="text-red-600 hover:text-red-900" title="Delete">
                                                                    <i class="fas fa-trash-alt"></i>
                                                                </a>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6" class="px-6 py-4 text-center text-gray-500">
                                                    No users found.
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div id="deleteModal" class="fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center z-50 hidden">
            <div class="bg-white rounded-lg p-8 max-w-md w-full">
                <h3 class="text-xl font-bold text-gray-900 mb-4">Confirm Deletion</h3>
                <p class="text-gray-600 mb-6">Are you sure you want to delete user <span id="userName" class="font-medium"></span>? This action cannot be undone.</p>
                <div class="flex justify-center space-x-4">
                    <button onclick="closeModal()" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300">
                        Cancel
                    </button>
                    <a id="deleteLink" href="#" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700">
                        Delete
                    </a>
                </div>
            </div>
        </div>

        <script>
            function confirmDelete(userId, userName) {
                document.getElementById('userName').textContent = userName;
                document.getElementById('deleteLink').href = '${pageContext.request.contextPath}/admin/user-delete?id=' + userId;
                document.getElementById('deleteModal').classList.remove('hidden');
            }

            function closeModal() {
                document.getElementById('deleteModal').classList.add('hidden');
            }
        </script>
    </body>
</html>