<%@ import Namespace="SoferDProductNameSpace" %>
<%@ import Namespace="SoferDCartNameSpace" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="VB" runat="server">
   Dim objCart as SoferDCartClass
	Dim objProduct as SoferDProductClass
	Dim objDS As New DataSet()
	Public strOrdNo As String
	Sub Page_Load(Source As Object, E As EventArgs) 
	    objProduct = New SoferDProductClass()	
	    objCart = New SoferDCartClass()
		 strOrdNo = objCart.getOrdNo()	
	    if NOT (isPostBack)
			 dlMainCat.DataSource = objProduct.getAllMainCat()
			 dlMainCat.DataBind()
			 objCart.OrdNo = strOrdNo		 
			 objDS = objCart.getCart()
			 DataBind()
			 pnlProduct.Visible = False
			 pnlCart.Visible = True
	    end if	
	End Sub
	
   Sub dlMainCat_Select(Sender As Object, E As EventArgs)
	   objProduct.strMainCatNo = csng(dlMainCat.DataKeys(dlMainCat.SelectedItem.ItemIndex))     
	   dlSubCat.DataSource = objProduct.getAllSubCat()
	   dlSubCat.DataBind()	
   End Sub	
		
   Sub dlSubCat_Select(Sender As Object, E As EventArgs)
	   pnlCart.Visible = False
        pnlProduct.Visible = True
	   objProduct.strSubCatID = csng(dlSubCat.DataKeys(dlSubCat.SelectedItem.ItemIndex))     
	   dlProduct.DataSource = objProduct.getSubProduct()
	   dlProduct.DataBind()	
   End Sub
	
   Sub dlProductView_Select(Sender As Object, E As EventArgs)
	   objProduct.strProductID = csng(dlProduct.DataKeys(dlProduct.SelectedItem.ItemIndex))     
	   dlProductView.DataSource = objProduct.getTheProduct()
	   dlProductView.DataBind()
   End Sub		
	
	Sub DataBind()
	   objDS = objCart.getCart()
		MyCartDataGrid.DataSource = objDS.Tables(0).DefaultView
		MyCartDataGrid.DataBind()
	End Sub	
	
	Sub Delete_Command(sender As Object, e As CommandEventArgs) 	
	    objCart.OrdNo = strOrdNo	
		 objCart.ProductNo = e.CommandName 												    
	    objCart.deleteOrdLine()
	    DataBind()							 							 
	End Sub				

	Sub Update_Command(sender As Object, e As CommandEventArgs)			
	    Dim i As Integer
	    For i = 0 To MyCartDataGrid.Items.Count - 1
	        Dim tbQuantity As TextBox = CType(MyCartDataGrid.Items(i).FindControl("Quantity"), TextBox)
	        Dim intQuantity as Integer
	        intQuantity = CInt(tbQuantity.Text)
	        Dim lblProductID As Label = Ctype(MyCartDataGrid.Items(i).FindControl("ProductID"), Label)
			  Dim strProductNo as string
			  strProductNo = lblProductID.Text
           If intQuantity = 0 Then
			     objCart.OrdNo = strOrdNo
				  objCart.ProductNo = strProductNo
              objCart.deleteOrdLine()
           Else
			     objCart.OrdNo = strOrdNo
				  objCart.Quantity = intQuantity 
				  objCart.ProductNo = strProductNo
              objCart.updateOrdLine()
           End If
	    Next
	    DataBind()		
	End Sub	
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>DJ's Shopping Cart</title>
    <link type="text/css" href="layout.css" rel="Stylesheet" />
</head>
<body>
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
            <form id="Form1" runat="server">
            <h3>Categories</h3>
            <ul class="categories">
            <asp:datalist id="dlMainCat" runat="server" onselectedindexchanged="dlMainCat_Select" datakeyfield="main_cat_no">
	            <ItemTemplate> 
   	                <li><asp:LinkButton id="main_cat_no" Text='<%# DataBinder.Eval(Container.DataItem, "main_cat_name") %>' CommandName="Select" runat="server" /></li>
	            </ItemTemplate>
            </asp:datalist>
            </ul>

            <h3>Sub Categories</h3>
            <ul class="subcategories">
            <asp:datalist id="dlSubCat" runat="server" onselectedindexchanged="dlSubCat_Select" datakeyfield="sub_cat_id">
                <ItemTemplate> 
                    <li><asp:LinkButton id="sub_cat_id" Text='<%# DataBinder.Eval(Container.DataItem, "sub_cat_name") %>' CommandName="Select" runat="server" /></li>
                </ItemTemplate>
            </asp:datalist>
            </ul>
        </div>
        <div id="maincontent">
            <!-- product list -->
			<asp:Panel id="pnlProduct" Runat=Server>
            <ul class="productlist">
            <asp:datalist id="dlProduct" runat="server" onselectedindexchanged="dlProductView_Select"
                datakeyfield="product_id">
	            <ItemTemplate> 
	               <li>$<%# DataBinder.Eval(Container.DataItem, "unit_price") %> <asp:LinkButton id="product_no" Text='<%# DataBinder.Eval(Container.DataItem, "product_name") %>' CommandName="Select" runat="server" /></li>
	            </ItemTemplate>
            </asp:datalist>
            </ul>
            </asp:Panel>
		   <!-- cart -->
			<asp:Panel id="pnlCart" runat="server">
        	    <h2>Your shopping cart <asp:ImageButton id="Imagebutton2" runat="server" AlternateText="Update Item" ImageUrl="images/update.gif" OnCommand="Update_Command" CommandName="Update"/></h2>
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
                        <asp:label ID='ProductID' Text='<%#Container.DataItem("product_no")%>' Runat="server" /></td>
                        <td><%#Container.DataItem("product_name")%></td>
                        <td><%# Databinder.eval(Container.DataItem, "unit_price", "{0:C}") %></td>
                        <td><asp:textbox Text='<%#Container.DataItem("quantity")%>' columns ="2" Runat="server"  id="quantity" /></td>
                        <td><asp:label Text='<%#formatCurrency(Container.DataItem("quantity") * Container.DataItem("unit_price")) %> ' columns ="2" Runat="server" ID="Textbox1" NAME="Textbox1"/></td>
                        <td><asp:ImageButton id="imagebutton1" runat="server" AlternateText="Remove Item" ImageUrl="images/remove.gif" OnCommand="Delete_Command" CommandName=<%#Container.DataItem("product_no")%>/>
                    </ItemTemplate>
                </asp:datalist>
			</asp:Panel>
			</form>
            <!-- product template -->
            <div class="product">
                <form action="addcart.aspx" method="post">
                <asp:datalist id="dlProductView" runat="server">
                <ItemTemplate> 
                   <h4><%# DataBinder.Eval(Container.DataItem, "product_name") %></h4>
                   <input class="submit" type="submit" value="Add to Cart" />
                    <div><span class="price">$<%# DataBinder.Eval(Container.DataItem, "unit_price") %></span><%# DataBinder.Eval(Container.DataItem, "product_no") %></div>
                    <div>Year:<%# DataBinder.Eval(Container.DataItem, "year") %></div>
                    <div><%# DataBinder.Eval(Container.DataItem, "rental_type") %> Rental</div>
                    <label for="quantity">Quantity:<input type="text" name="quantity" size="2" /></label>
                    <input type="hidden" name="product_id" value="<%# DataBinder.Eval(Container.DataItem, "product_id") %>">							
                </ItemTemplate>
                </asp:datalist>
                </form>
            </div>
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
</body>
</html>