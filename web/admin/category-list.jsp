<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Categories - Admin Dashboard</title>
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
                        <h1 class="text-2xl font-semibold text-gray-900">Manage Course Categories</h1>
                        <a href="${pageContext.request.contextPath}/admin/category-add" 
                           class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <i class="fas fa-plus mr-2"></i> Add New Category
                        </a>
                    </div>
                </header>

                <!-- Main Content -->
                <main class="flex-1 overflow-y-auto p-4 sm:p-6 lg:p-8">
                    <!-- Status Messages -->
                    <c:if test="${param.message != null}">
                        <div class="mb-4 px-4 py-3 rounded relative
                             ${param.message == 'added' || param.message == 'updated' || param.message == 'deleted' ? 'bg-green-100 border border-green-400 text-green-700' : ''}
                             ${param.message == 'error' || param.message == 'notfound' ? 'bg-red-100 border border-red-400 text-red-700' : ''}
                             ${param.message == 'invalid' || param.message == 'inuse' ? 'bg-yellow-100 border border-yellow-400 text-yellow-700' : ''}">
                            <span class="block sm:inline">
                                <c:choose>
                                    <c:when test="${param.message == 'added'}">
                                        <i class="fas fa-check-circle mr-2"></i>Category has been successfully added.
                                    </c:when>
                                    <c:when test="${param.message == 'updated'}">
                                        <i class="fas fa-check-circle mr-2"></i>Category has been successfully updated.
                                    </c:when>
                                    <c:when test="${param.message == 'deleted'}">
                                        <i class="fas fa-check-circle mr-2"></i>Category has been successfully deleted.
                                    </c:when>
                                    <c:when test="${param.message == 'error'}">
                                        <i class="fas fa-exclamation-circle mr-2"></i>An error occurred. Please try again.
                                    </c:when>
                                    <c:when test="${param.message == 'notfound'}">
                                        <i class="fas fa-exclamation-circle mr-2"></i>Category not found.
                                    </c:when>
                                    <c:when test="${param.message == 'invalid'}">
                                        <i class="fas fa-exclamation-triangle mr-2"></i>Invalid category ID provided.
                                    </c:when>
                                    <c:when test="${param.message == 'inuse'}">
                                        <i class="fas fa-exclamation-triangle mr-2"></i>Cannot delete category because it is being used by one or more courses.
                                    </c:when>
                                </c:choose>
                            </span>
                        </div>
                    </c:if>

                    <!-- Categories Table -->
                    <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            ID
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Category Name
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:choose>
                                        <c:when test="${not empty categories && categories.size() > 0}">
                                            <c:forEach items="${categories}" var="category">
                                                <tr>
                                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                        ${category.id}
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                        <div class="text-sm font-medium text-gray-900">
                                                            ${category.name}
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                        <div class="flex justify-end space-x-2">
                                                            <a href="${pageContext.request.contextPath}/admin/category-edit?id=${category.id}" 
                                                               class="text-blue-600 hover:text-blue-900" title="Edit">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="#" onclick="confirmDelete(${category.id}, '${category.name}')" 
                                                               class="text-red-600 hover:text-red-900" title="Delete">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="3" class="px-6 py-4 text-center text-gray-500">
                                                    No categories found.
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
                <p class="text-gray-600 mb-6">Are you sure you want to delete the category <span id="categoryName" class="font-medium"></span>? This action cannot be undone.</p>
                <div class="flex justify-end space-x-4">
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
            function confirmDelete(categoryId, categoryName) {
                document.getElementById('categoryName').textContent = categoryName;
                document.getElementById('deleteLink').href = '${pageContext.request.contextPath}/admin/category-delete?id=' + categoryId;
                document.getElementById('deleteModal').classList.remove('hidden');
            }

            function closeModal() {
                document.getElementById('deleteModal').classList.add('hidden');
            }
        </script>
    </body>
</html>