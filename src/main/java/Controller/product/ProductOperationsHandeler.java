package Controller.product;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.imageio.ImageIO;

import Controller.dbconnection.DbConnection;
import Model.Product;

public class ProductOperationsHandeler {

	public static int addProduct(Product product) throws SQLException {
		
		Connection con = DbConnection.getDbConnection();
		
		String insertQuery = "insert into Products(productName, brandName, productCategory, productImg, productPrice, productRating, productStock) "
				+ "values(?,?,?,?,?,?,?)";
		
		PreparedStatement statement = con.prepareStatement(insertQuery);
		
		statement.setString(1, product.getProductName());
		statement.setString(2,product.getBrandName());
		statement.setString(3,product.getProductCategory());
		statement.setBlob(4,product.getProductImg());
		statement.setFloat(5,product.getProductPrice());
		statement.setFloat(6,product.getProductRating());
		statement.setInt(7,product.getProductStock());

		int result = statement.executeUpdate();		
		
		con.close();
		
		return result;
	}
	
	public static int deleteProduct(int productID) throws SQLException {
		
		Connection con = DbConnection.getDbConnection();
		
		String deletQuery = "DELETE FROM Products where productID = ?";
		
		PreparedStatement statement = con.prepareStatement(deletQuery);
		
		statement.setInt(1, productID);
		
		int result = 0;
		
		result = statement.executeUpdate();
		
		con.close();
		
		return result;
		
		
	}
	
	
	public static int updateProductDetails(Product product) throws SQLException {
		
		Connection con = DbConnection.getDbConnection();
		
		String updateQuery = "UPDATE Products SET productName = ?, brandName = ?, productCategory = ? , productImg = ?,"
				+ "productPrice = ?, productRating = ?, productStock = ? WHERE productID = ?";
		
		PreparedStatement statement = con.prepareStatement(updateQuery);
		
		statement.setString(1, product.getProductName());
		statement.setString(2,product.getBrandName());
		statement.setString(3,product.getProductCategory());
		statement.setBlob(4,product.getProductImg());
		statement.setFloat(5,product.getProductPrice());
		statement.setFloat(6,product.getProductRating());
		statement.setInt(7,product.getProductStock());
		
		int result = 0;
		
		result = statement.executeUpdate();
		
		return result;
		
	}
	
	
	public static Product getProductById(int productID) throws SQLException, IOException {
		
		Connection con = DbConnection.getDbConnection();
		
		String selectProduct = "SELECT * FROM Products WHERE productID = ?";
		
		PreparedStatement statement = con.prepareStatement(selectProduct);
		
		statement.setInt(1, productID);
		
		ResultSet productFromDB = statement.executeQuery();
		
		Product product = null;
		
		while(productFromDB.next()) {
			
			product = new Product();
			
			product.setProductID(productFromDB.getInt(1));
			product.setProductName(productFromDB.getString(2));
			product.setBrandName(productFromDB.getString(3));
			product.setProductCategory(productFromDB.getString(4));
			product.setProductPrice(productFromDB.getFloat(6));
			product.setProductRating(productFromDB.getFloat(7));
			product.setProductStock(productFromDB.getInt(8));
			
			Blob productImgBlob = productFromDB.getBlob(5);
			
			String productImg = convertBlopToBase64(productImgBlob);
            
			product.setProductImgFromDB(productImg);

		}
		
		
		return product;		
		
	}
		
	
	public static List<Product> getAllProducts() throws SQLException, IOException{
		
		//createing an arrray list
		
		List<Product> allProducts = new ArrayList<Product>();
		
		Connection con = DbConnection.getDbConnection();
		
		String selectQuery = "select * from Products";
		
		PreparedStatement statement = con.prepareStatement(selectQuery);
		
		ResultSet productsFromDB = statement.executeQuery();
		
		while(productsFromDB.next()) {
			Product product = new Product();
			
			product.setProductID(productsFromDB.getInt(1));
			product.setProductName(productsFromDB.getString(2));
			product.setBrandName(productsFromDB.getString(3));
			product.setProductCategory(productsFromDB.getString(4));
			product.setProductPrice(productsFromDB.getFloat(6));
			product.setProductRating(productsFromDB.getFloat(7));
			product.setProductStock(productsFromDB.getInt(8));
			
			
			Blob productImgBlob = productsFromDB.getBlob(5);
			
			String productImg = convertBlopToBase64(productImgBlob);
            
			product.setProductImgFromDB(productImg);

            
            allProducts.add(product);
		}
		
		con.close();
		
		return allProducts;
		
	}
	
	public static String convertBlopToBase64(Blob fileBlob) throws SQLException, IOException {
		
		byte[] imageData = fileBlob.getBytes(1, (int)fileBlob.length());
		
		// Create an image from the byte array
		ByteArrayInputStream bis = new ByteArrayInputStream(imageData);
		BufferedImage image = ImageIO.read(bis);

		 // Write the image to the response output stream
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		  
		if(image != null) {
		  ImageIO.write(image, "png", baos);
		}
		  
		baos.flush();
		byte[] imageBytes = baos.toByteArray();
		baos.close();

		// Convert the image byte array to a Base64-encoded string
		String imgBase64 = Base64.getEncoder().encodeToString(imageBytes);
		
		return imgBase64;
	}
}