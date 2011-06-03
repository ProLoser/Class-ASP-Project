<%@ import Namespace="SoferDProductNameSpace" %>
<%@ import Namespace="SoferDCartNameSpace" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="VB" runat="server">
   Dim objCart as SoferDCartClass
	Dim objProduct as SoferDProductClass
    Dim objDS As New DataSet()
    Dim objHeadDS As New DataSet()
	Public strOrdNo As String
	Sub Page_Load(Source As Object, E As EventArgs) 
	    objProduct = New SoferDProductClass()	
	    objCart = New SoferDCartClass()
		 strOrdNo = objCart.getOrdNo()	
        objCart.ordNo = strOrdNo
        objDS = objCart.getCart()
        DataBind()
    End Sub
    
	Sub DataBind()
	   objDS = objCart.getCart()
		MyCartDataGrid.DataSource = objDS.Tables(0).DefaultView
        MyCartDataGrid.DataBind()
        objHeadDS = objCart.getOrdHead()
        MyOrdHeadDataGrid.DataSource = objHeadDS.Tables(0).DefaultView
        MyOrdHeadDataGrid.DataBind()
	End Sub	
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>DJ's Shopping Cart</title>
    <link type="text/css" href="layout.css" rel="Stylesheet" />
</head>
<body>
<form runat="server">
    <div id="container">
    <div id="header">
        <h2>
            DJ's Shopping Cart
            <span>Limit 1 Epic per customer</span>
        </h2>
        <ul>
            <li><a href="default.aspx">Home</a></li>
            <li><a href="mycart.aspx">Shopping Cart</a></li>
            <li><a href="checkout.aspx">Checkout</a></li>
        </ul>   
    </div>
    <div id="body">
        <div id="navigation">
        </div>
        <div id="maincontent">
            <h1>Thank You</h1>
            
		   <!-- cart -->
      	    <asp:datalist id="MyOrdHeadDataGrid" runat="server">
                <ItemTemplate>
                    <p><b>Order #:</b> <%#Container.DataItem("order_no")%></p>
                    <p><b>Order Date:</b> <%#Container.DataItem("ord_date")%> at <%#Container.DataItem("ord_time")%></p>
                    <p><b>Name:</b> <%#Container.DataItem("firstname")%> <%#Container.DataItem("lastname")%></p>
                    <p><b>Email:</b> <%#Container.DataItem("email")%></p>
                    <p><b>Address:</b></p>
                    <p><%#Container.DataItem("address")%></p>
                    <p><%#Container.DataItem("city")%>, <%#Container.DataItem("state")%> <%#Container.DataItem("zip")%></p>
                    <p><b>Phone #:</b> <%#Container.DataItem("phone")%></p>
                    <p><b>Credit Card:</b> <%#Container.DataItem("cardtype")%> <%#Container.DataItem("cardno")%></p>
                    <p><b>Subtotal:</b> <%#Container.DataItem("subtotal")%></p>
                    <p><b>Tax:</b> <%#Container.DataItem("tax")%></p>
                    <p><b>Total:</b> <%#Container.DataItem("total")%></p>
                </ItemTemplate>
            </asp:datalist>
      	    <asp:datalist id="MyCartDataGrid" runat="server">
      	        <HeaderTemplate>
                    Product#</td>
                    <td width=35%>Description</td>
                    <td width=10%>Price</td>
                    <td width=10%>Quantity</td>
                    <td width=15%>Subtotal</td>
                    <td width="60px">
                </HeaderTemplate>
                <ItemTemplate>
                    <%#Container.DataItem("product_no")%></td>
                    <td><%#Container.DataItem("product_name")%></td>
                    <td><%# Databinder.eval(Container.DataItem, "unit_price", "{0:C}") %></td>
                    <td><%#Container.DataItem("quantity")%></td>
                    <td><%#formatCurrency(Container.DataItem("quantity") * Container.DataItem("unit_price")) %></td>
                </ItemTemplate>
            </asp:datalist>
        </div>
    </div>
    <div id="footer">
        <ul>
            <li>Copyright 2010 Dean Sofer</li>
            <li><a href="contact.aspx">Contact Us</a></li>
            <li><a href="terms_of_service.aspx">Terms of Service</a></li>
        </ul>
    </div>
    </div>
    
</form>
</body>
</html>