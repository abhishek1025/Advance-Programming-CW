package Resources;

public class MyConstants {
	
	public static final String IMAGE_DIR = "/Applications/XAMPP/xamppfiles/tomcat/apache-tomcat-8.5.86/webapps/ROOT/images/";
	

	public static final String DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
	public static final String DB_URL = "jdbc:mysql://localhost:3306/TrendyAttire";
	public static final String DB_USERNAME = "root";
	public static final String DB_PASSWORD =""	;	
	
	public static final String PRODUCT_INSERT_QUERY = "insert into Products(productName, brandName, productCategory, productImg, productPrice, "
			+ "productRating, productStock) values(?,?,?,?,?,?,?)";
	
	public static final String PRODUCT_DELETE_QUERY = "DELETE FROM Products where productID = ?";
	
	public static final String GET_PRODUCT_BY_ID_QUERY = "SELECT * FROM Products WHERE productID = ?";
	
	
	public static String convertArrayToString(String[] array) {
		
		String result = "";
		
		for (String s : array) {
		    result += "\"" + s.toLowerCase() + "\", ";
		}
		
		result = result.substring(0, result.length() - 2);
		
		return result;
	}
	
	
	public static final String[] PRODUCT_BRANDS = {"Nike", "H&M", "Adidas", "Zara", "Lewis"};
	public static final String[] PRODUCT_CATEGORIES = {"Men", "Women", "Kids", "Unisex"};
	
	
	public static final String URL_FOR_FILTERING_PRODUCTS = "View/pages/product-page.jsp?operationType=filterProducts&priceFrom=100&priceTo=5000&ratingFrom=0&ratingTo=5";
}