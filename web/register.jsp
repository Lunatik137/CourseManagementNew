<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - Course Management System</title>
        <!-- Tailwind CSS CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-gray-100 min-h-screen">
        <!-- Include Header -->
        <jsp:include page="header.jsp" />

        <div class="container mx-auto px-4 py-16 flex items-center justify-center">
            <div class="max-w-md w-full bg-white rounded-lg shadow-md overflow-hidden">
                <div class="px-6 py-8">
                    <h2 class="text-2xl font-bold text-center text-gray-800 mb-8">Create an Account</h2>

                    <!-- Error Message -->
                    <c:if test="${not empty errorMessage}">
                        <div class="mb-4 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded" role="alert">
                            <p>${errorMessage}</p>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post">
                        <!-- Username -->
                        <div class="mb-4">
                            <label for="username" class="block text-gray-700 text-sm font-bold mb-2">Username *</label>
                            <input type="text" id="username" name="username" value="${username}" required
                                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            <c:if test="${not empty usernameError}">
                                <p class="text-red-500 text-xs italic mt-1">${usernameError}</p>
                            </c:if>
                        </div>

                        <!-- Password -->
                        <div class="mb-4">
                            <label for="password" class="block text-gray-700 text-sm font-bold mb-2">Password *</label>
                            <input type="password" id="password" name="password" required
                                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            <c:if test="${not empty passwordError}">
                                <p class="text-red-500 text-xs italic mt-1">${passwordError}</p>
                            </c:if>
                        </div>

                        <!-- Confirm Password -->
                        <div class="mb-4">
                            <label for="confirmPassword" class="block text-gray-700 text-sm font-bold mb-2">Confirm Password *</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required
                                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            <c:if test="${not empty confirmPasswordError}">
                                <p class="text-red-500 text-xs italic mt-1">${confirmPasswordError}</p>
                            </c:if>
                        </div>

                        <!-- Email -->
                        <div class="mb-4">
                            <label for="email" class="block text-gray-700 text-sm font-bold mb-2">Email *</label>
                            <input type="email" id="email" name="email" value="${email}" required
                                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            <c:if test="${not empty emailError}">
                                <p class="text-red-500 text-xs italic mt-1">${emailError}</p>
                            </c:if>
                        </div>

                        <!-- Phone Number -->
                        <div class="mb-4">
                            <label for="phoneNumber" class="block text-gray-700 text-sm font-bold mb-2">Phone Number</label>
                            <input type="tel" id="phoneNumber" name="phoneNumber" value="${phoneNumber}"
                                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                        </div>

                        <!-- Student ID - New Field -->
                        <div class="mb-4">
                            <label for="studentID" class="block text-gray-700 text-sm font-bold mb-2">Student ID</label>
                            <input type="text" id="studentID" name="studentID" value="${studentID}"
                                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            <p class="text-gray-500 text-xs italic mt-1">Enter your student identification number if applicable.</p>
                            <c:if test="${not empty studentIDError}">
                                <p class="text-red-500 text-xs italic mt-1">${studentIDError}</p>
                            </c:if>
                        </div>

                        <!-- Gender -->
                        <div class="mb-4">
                            <label class="block text-gray-700 text-sm font-bold mb-2">Gender</label>
                            <div class="flex items-center">
                                <input type="radio" id="male" name="gender" value="Male" ${gender == 'Male' ? 'checked' : ''} class="mr-2">
                                <label for="male" class="mr-4">Male</label>
                                <input type="radio" id="female" name="gender" value="Female" ${gender == 'Female' ? 'checked' : ''} class="mr-2">
                                <label for="female">Female</label>
                            </div>
                        </div>

                        <!-- Date of Birth -->
                        <div class="mb-4">
                            <label for="dob" class="block text-gray-700 text-sm font-bold mb-2">Date of Birth</label>
                            <input type="date" id="dob" name="dob" value="${dob}"
                                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                        </div>

                        <!-- Identity Card -->
                        <div class="mb-6">
                            <label for="identityCard" class="block text-gray-700 text-sm font-bold mb-2">Identity Card</label>
                            <input type="text" id="identityCard" name="identityCard" value="${identityCard}"
                                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                        </div>

                        <!-- Submit Button -->
                        <div class="flex items-center justify-between">
                            <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline w-full">
                                Register
                            </button>
                        </div>

                        <!-- Login Link -->
                        <div class="text-center mt-6">
                            <p class="text-sm text-gray-600">
                                Already have an account? <a href="${pageContext.request.contextPath}/login" class="text-blue-500 hover:text-blue-700">Login here</a>
                            </p>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Include Footer -->

    </body>
</html>