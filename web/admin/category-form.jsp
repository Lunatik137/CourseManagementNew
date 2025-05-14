<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${category != null ? 'Edit' : 'Add'} Category - Admin Dashboard</title>
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
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
                        <h1 class="text-2xl font-semibold text-gray-900">
                            ${category != null ? 'Edit' : 'Add New'} Category
                        </h1>
                    </div>
                </header>

                <!-- Main Content -->
                <main class="flex-1 overflow-y-auto p-4 sm:p-6 lg:p-8">
                    <!-- Error Message -->
                    <c:if test="${error != null}">
                        <div class="mb-6 px-4 py-3 bg-red-100 border border-red-400 text-red-700 rounded-lg shadow-sm">
                            <span class="block sm:inline">
                                <i class="fas fa-exclamation-circle mr-2"></i>${error}
                            </span>
                        </div>
                    </c:if>

                    <!-- Category Form -->
                    <div class="bg-white shadow-md rounded-lg overflow-hidden max-w-3xl mx-auto">
                        <div class="px-6 py-8">
                            <form action="${pageContext.request.contextPath}/admin/${category != null ? 'category-edit' : 'category-add'}" method="post">
                                <c:if test="${category != null}">
                                    <input type="hidden" name="id" value="${category.id}">
                                </c:if>
                                
                                <div class="mb-6">
                                    <label for="categoryName" class="block text-sm font-medium text-gray-700 mb-2">Category Name</label>
                                    <input type="text" name="categoryName" id="categoryName" 
                                           value="${category != null ? category.name : categoryName}"
                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-base"
                                           placeholder="Enter category name"
                                           required>
                                    <p class="mt-1 text-xs text-gray-500">Enter a descriptive name for the category</p>
                                </div>
                                
                                <div class="flex justify-end space-x-4 mt-8">
                                    <a href="${pageContext.request.contextPath}/admin/categories" 
                                       class="px-6 py-3 border border-gray-300 rounded-lg text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 shadow-sm transition duration-150 ease-in-out">
                                        Cancel
                                    </a>
                                    <button type="submit" 
                                            class="px-6 py-3 border border-transparent rounded-lg text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 shadow-sm transition duration-150 ease-in-out">
                                        ${category != null ? 'Update' : 'Add'} Category
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </body>
</html>