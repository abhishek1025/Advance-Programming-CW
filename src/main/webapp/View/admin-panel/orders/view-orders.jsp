<%@page import="utils.ManageCookie"%>
<%@page import="dao.OrderDAO"%>
<%@page import="model.OrderDetails"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/view-orders.css">
</head>

<body>

	<%! String[] adminData = {}; %>
	<% adminData = ManageCookie.getCookiesData(request, "adminData"); %>

 	<aside>

        <section class="admin-details-wrapper">
        
            <div class="admin-img">
                <img src="http://localhost:8080/images/userImages/<%=adminData[2] %>" alt="Admin" height="130px">
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

            <div class="panel-function">
                <img src="${pageContext.request.contextPath}/assets/product.svg" alt="Dashboard" height="18.5px">

                <a href="${pageContext.request.contextPath}/View/admin-panel/add-product/add-product.jsp"> Add Product </a>
            </div>

            <div class="active-dashboard-tab panel-function">

                <img class="blue" src="${pageContext.request.contextPath}/assets/cart.svg" alt="Dashboard" height="18.5px">

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

            <h1>Orders</h1>

            <div class="order-list">
                <table>
                    <tr>
                        <th style="width: 15%;">SN</th>
                        <th>Customer Name</th>
                        <th style="width: 20%;">Order Total</th>
                        <th style="width: 23%;">Order Date</th>
                    </tr>


                    <%
                    	OrderDAO orderdao = new OrderDAO();
                    
                    	List<OrderDetails> allOrders = orderdao.getAllOrderDetails();
                    	
                    	int SN = 1;

                    	for(OrderDetails order: allOrders){
					%>
							<tr>
		                        <td><%=SN++%></td>
		                        <td><%=order.getCustomerName() %></td>
		                        <td>NPR <%=order.getOrderTotal() %></td>
		                        <td><%=order.getOrderDate().toString().replace("T", " ") %></td>
		                        
		                        <td>
		                        	<%-- <a href="order-items.jsp?customerName=<%=order.getCustomerName()%>&orderID=<%=order.getOrderID()%>"> --%>
		                        	<!-- </a> -->
		                        	
		                        	<form method="POST" action="order-items.jsp">
		                        	
		                        		<input type="hidden" name="orderID" value="<%=order.getOrderID()%>">
		                        		<input type="hidden" name="customerName" value="<%=order.getCustomerName()%>">
		                        		<input type="hidden" name="orderTotal" value="<%=order.getOrderTotal()%>">
		                        		<input type="hidden" name="orderDate" value="<%=order.getOrderDate().toString().replace("T", " ")%>">
		                        		
		                        		<button type="submit" style="all:unset; cursor:pointer; color:blue;">View Items</button>
		                        	
		                        	</form>
		                        </td>
		                        
		                    </tr>
                    <%}%>

                </table>
            </div>

        </section>
    </div>
</body>

</html>