<%@page import="utils.ManageCookie"%>
<%@page import="dao.UserDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trendy Attire | CHECKOUT </title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/checkout-page.css">

</head>

<body class="contact-us-page-body">

	<jsp:include page="/View/header.jsp"></jsp:include>

	<%!int totalCost;%>

    <div class="checkout-sec-wrapper">

        <h1>SHOPPING CART</h1>

        <div>
        
            <div class="cart-checkout-items">
            
            	<form method="POST" action="${pageContext.request.contextPath}/cartOperationsServelt">
	                
		        	<input type="hidden" name="cartOperationType" value="updateCartQuantity">
		                	
					<table cellspacing=0>
		                    
						<tr>
							<th style="width:50%">Product</th>
							<th style="width:20%">Price</th>
							<th>Quantity</th>
				        </tr>
            
           			 <%
           					CartDAO cartdao = new CartDAO();
           			 
							ResultSet cartItems = cartdao.getAllCartItems(request);
						
							int itemSN = -1;
							totalCost = 0;

							if(cartItems != null) {
											
								while(cartItems.next()) {
									
									totalCost += (cartItems.getInt(5) * cartItems.getInt(3)); 								
									itemSN++;
						%>			
									<tr>
				                       <td>
				                            <div class="cart-checkout-item-desc">
				                                <div class="item-img">
				                                    <img src="http://localhost:8080/images/<%=cartItems.getString(4) %>" width="100px">
				                                </div>
				                                <div>
				                                    <p>
				                                       <%=cartItems.getString(2) %>
				                                    </p>
				                                </div>
				                            </div>
				                        </td>
	
				                        <td>
				                            NPR <%=cartItems.getInt(3) %>
				                        </td>
	
				                        <td>
				                            <div class="cart-checkout-item-quantity-wrapper">
				                            
				                                <div class=" cart-checkout-item-quantity">
				                                
				                                    <button type="button" class="decreaseBtn" onclick="decreaseQuantity(<%=itemSN%>)">
				                                        -
				                                    </button>
				                                    
													<input type="hidden" name="cartItemID" value="<%=cartItems.getInt(1)%>"/>
													
													<input type="hidden" name="oldQuantity" value="<%=cartItems.getInt(5)%>">
													
													<input type="hidden" name="productID" value="<%=cartItems.getInt(6)%>">
													
				                                    <input type="number" min="1" max="<%=cartItems.getInt(7) + cartItems.getInt(5)%>" name="newQuantity" value="<%=cartItems.getInt(5)%>" class="productQuantity">
				                                    
	
				                                    <button type="button" class="increaseBtn" onclick="increaseQuantity(<%=itemSN%>)">
				                                        +
				                                    </button>
				                                    
				                                </div>
	
				                                
				                                <a 
				                                	class="cart-checkout-delt-btn" 
				                                	href="${pageContext.request.contextPath}/cartOperationsServelt?cartOperationType=deleteCartItem&cartItemID=<%=cartItems.getInt(1)%>&productID=<%=cartItems.getInt(6)%>&quantity=<%=cartItems.getInt(5)%>">
				                                   		 &#10005;
				                                </a>
				                                	
	
				                            </div>
	
				                        </td>
				                    </tr>
				                    
						<%
								}
						
								if(itemSN == -1){
						%>
									<tr>
									
										<td> - </td>
										
										<td> - </td>
										
										<td> - </td>
									
									</tr>
							
						<%		
								}
							}
						%>
						
					</table>
					
					<%
						if(itemSN != -1){
					%>
							<button type="submit" class="cart-update-btn">Update Cart</button>
					<%	} %>
							
							
				</form>
            
						
            </div>


            <% 
           		 String[] userData = ManageCookie.getCookiesData(request, "userData");
            
            	if(totalCost != 0) { 
            %>
					<div class="order-price-details">
		                <p><span>Subtotal</span> <span>NPR <%=totalCost %></span></p>
		                <p><span>Shipping Cost</span> <span>NPR 100</span></p>
		                <div style="border-top: 1px solid #ccc; margin:20px 0;"></div>
		                <p><span>Grand Total</span> <span>NPR <%=totalCost + 100 %></span></p>
		
		                <div class="cart-checkout-btn">
		                   
		                   <form action="${pageContext.request.contextPath}/PlaceOrderServlet" method="Post">
		                   
		                   		<input type="hidden" name="userID" value="<%=userData[0]%>">
		                   		<input type="hidden" name="userFullName" value="<%=userData[1] + " " + userData[2]%>">
		                   		
		                   		<input type="hidden" name="orderTotal" value="<%=totalCost + 100 %>">
		                   
		                   	 	<button type="submit">
		                    	    Proceed to Checkout
		                    	</button>
		                   
		                   
		                   </form>
		                   
		                </div>
		
		            </div>
            <% } %>
            
        </div>

    </div>
    
    <jsp:include page="/View/footer.jsp"></jsp:include>

    <script src="${pageContext.request.contextPath}/JS/checkout-page.js"></script>

</body>

</html>