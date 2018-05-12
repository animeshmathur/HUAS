<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.apache.commons.fileupload.disk.*"%>
<%@page import="org.apache.commons.fileupload.servlet.*"%>
<%@page import="org.apache.commons.io.output.*"%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/HUAS","hucky","13071992");
	Statement smt=cn.createStatement();
	
	HttpSession ses=request.getSession(true);
	String userid=ses.getValue("userid").toString();
	ses.putValue("userid",userid);
	
	String item_id=ses.getValue("item_id").toString();
	//out.println("Hello!");

	DiskFileItemFactory factory=new DiskFileItemFactory();
	factory.setSizeThreshold(1024*1024*1024);
	factory.setRepository(new File("tmp/"));
	
	ServletFileUpload upload=new ServletFileUpload(factory);
	upload.setSizeMax(1024*1024*1024);
	
	List fileItems=upload.parseRequest(request);
	
	Iterator i=fileItems.iterator();
	
	FileItem fi=(FileItem)i.next();
	
	String fileName=fi.getName();
	int fileNameLength=fileName.length();
	String fileExtension=fileName.substring(fileNameLength-4,fileNameLength);
	
	String image_nm=item_id;
	

		if(fileExtension.equalsIgnoreCase(".jpg"))
		{
			fileName=image_nm+fileExtension;
		}
		else if(fileExtension.equalsIgnoreCase("jpeg"))
		{
			fileName=image_nm+"."+fileExtension;
		}
		else if(fileExtension.equalsIgnoreCase(".bmp"))
		{
			fileName=image_nm+fileExtension;
		}
		else if(fileExtension.equalsIgnoreCase(".png"))
		{
			fileName=image_nm+fileExtension;
		}
		else
		{
			response.sendRedirect("user_seller_edit_item_details.jsp?msg=0&item_id="+item_id);
		}
	
	//out.println("Name of file:"+fileName);
	
	File file;
	
	String filePath="/usr/tomcat/webapps/ROOT/Project/User/uploads/";
	
	if(fileName.lastIndexOf("\\") >= 0 )
	{
		file=new File(filePath+fileName.substring(fileName.lastIndexOf("\\")));
    }
    else
    {
        file=new File(filePath+fileName.substring(fileName.lastIndexOf("\\")+1));
    }
	
	fi.write(file);
	
	//out.println("File Uploaded!");
	
	//Database Entry
	smt.executeUpdate("update seller_items set seller_item_image='"+fileName+"' where seller_item_id='"+item_id+"'");
	//
	
	response.sendRedirect("user_items.jsp");
}
catch(Exception ex)
{
	out.println(ex);
	//response.sendRedirect("../index.jsp?invalid_access=1");
}
%>
