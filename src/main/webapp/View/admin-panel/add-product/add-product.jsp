<%@page import="utils.ManageCookie"%>
<%@page import="dao.UserDAO"%>
<%@page import="appConstants.MyConstants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Product</title>
        
        <!-- Google Font CDN  -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
	    
	    <!-- CSS Files-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/dashboard-sidebar.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/add-product.css">
    </head>

    <body>

	<%! String[] adminData = {}; %>
	<% adminData = ManageCookie.getCookiesData(request, "adminData"); %>

 	<aside>

        <section class="admin-details-wrapper">
        
            <div class="admin-img">
                <img src="http://localhost:8080/images/userImages/<%=adminData[2]%>" alt="Admin" height="130px">
            </div>

            <div class="admin-details">
                <h3><%=adminData[0]%>  <%=adminData[1] %></h3>
            </div>
            
        </section>

            <section class="panel-functions">

                <div class="panel-function">

                    <img src="${pageContext.request.contextPath}/assets/dashboard.svg" alt="Dashboard" height="18.5px">

                    <a href="${pageContext.request.contextPath}/View/admin-panel/dashboard/dashboard.jsp">Dashboard</a>

                </div>

                <div class="active-dashboard-tab panel-function">
                    <img class="blue" src="${pageContext.request.contextPath}/assets/product.svg" alt="Dashboard"
                        height="18.5px">

                    <a href="${pageContext.request.contextPath}/View/admin-panel/add-product/add-product.jsp"> Add
                        Product </a>
                </div>

                <div class="panel-function">

                    <img src="${pageContext.request.contextPath}/assets/cart.svg" alt="Dashboard" height="18.5px">

                    <a href="${pageContext.request.contextPath}/View/admin-panel/orders/view-orders.jsp">View Orders</a>

                </div>
                
                <div class="panel-function">

                	<img src="${pageContext.request.contextPath}/assets/sign-out.svg" alt="Dashboard" height="18.5px">

                	<a href="${pageContext.request.contextPath}/SignOutServlet">Sign out</a>

           		 </div>

            </section>

        </aside>


        <div class="admin-panel-wrapper">

            <section class="admin-panel-content">

                <h1>Add Product</h1>

                <form method="post" action="${pageContext.request.contextPath}/AddProduct" class="add-product-form"
                    enctype="multipart/form-data">

                    <div class="input-fields-wrapper">
                        <div>
                            <label>Product Name</label>
                        </div>

                        <div>
                            <input type="text" name="productName" required>
                        </div>
                    </div>

                    <div class="input-fields-wrapper">
                        <div>
                            <label>Brand Name</label>
                        </div>

                        <div>                            
                            <select name="brandName" required>
                                <option value="">Select Brand</option>
                                <%
			  						for(String brand: MyConstants.PRODUCT_BRANDS){
			 					%>
	         	 					<option value="<%=brand.toLowerCase()%>"> <%=brand %> </option>
	          					<%}%>
                            </select>
                        </div>
                    </div>

                    <div class="input-fields-wrapper">
                        <div>
                            <label>Category</label>
                        </div>

                        <div>
                            <select name="productCategory" required>
                                <option value="">Select Category</option>
                                <%
			  						for(String category: MyConstants.PRODUCT_CATEGORIES){
			 					%>
	         	 					<option value="<%=category.toLowerCase()%>"> <%=category %> </option>
	          					<%}%>
                            </select>
                        </div>
                    </div>

                    <div class="input-fields-wrapper">
                        <div>
                            <label>Image</label>
                        </div>

                        <div>
                            <input type="file" name="productImage" id="productImage" accept="image/*">
                        </div>


                        <div id="displayProductImg"></div>


                    </div>

                    <div class="input-multiple-fields-wrapper">

                        <div>
                            <div>
                                <label>Price</label>
                            </div>

                            <div>
                                <input type="number" step="any" min="100" max="20000" name="productPrice" required>
                            </div>
                        </div>

                        <div>
                            <div>
                                <label>Rating</label>
                            </div>

                            <div>
                                <input type="number" name="productRating" step=".01" max="5" min="0" required>
                            </div>
                        </div>

                        <div>
                            <div>
                                <label>Stock</label>
                            </div>

                            <div>
                                <input type="number" name="productStock" min="1" required>
                            </div>
                        </div>

                    </div>


                    <button type="submit" class="add-product-btn">Add Product</button>


                </form>

            </section>
        </div>

        <script src="${pageContext.request.contextPath}/JS/add-product.js"></script>
    </body>

    </html>