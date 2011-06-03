<%@ import Namespace="SoferDProductNameSpace" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="VB" runat="server">
    Dim objProduct As SoferDProductClass
	Sub Page_Load(Source As Object, E As EventArgs) 
        objProduct = New SoferDProductClass()
	   if NOT (isPostBack)
			dlMainCat.DataSource = objProduct.getAllMainCat()
			dlMainCat.DataBind()
	   end if	
	End Sub
   Sub dlMainCat_Select(Sender As Object, E As EventArgs)
	   objProduct.strMainCatNo = csng(dlMainCat.DataKeys(dlMainCat.SelectedItem.ItemIndex))     
	   dlSubCat.DataSource = objProduct.getAllSubCat()
	   dlSubCat.DataBind()	
   End Sub		
   Sub dlSubCat_Select(Sender As Object, E As EventArgs)
	   objProduct.strSubCatID = csng(dlSubCat.DataKeys(dlSubCat.SelectedItem.ItemIndex))     
	   dlProduct.DataSource = objProduct.getSubProduct()
	   dlProduct.DataBind()	
   End Sub
   Sub dlProductView_Select(Sender As Object, E As EventArgs)
	   objProduct.strProductID = csng(dlProduct.DataKeys(dlProduct.SelectedItem.ItemIndex))     
	   dlProductView.DataSource = objProduct.getTheProduct()
	   dlProductView.DataBind()
   End Sub	
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>DJ's Shopping Cart</title>
    <link type="text/css" href="layout.css" rel="Stylesheet" />
</head>
<body>
<form id="container" runat="server">
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
            <ul class="productlist">
            <asp:datalist id="dlProduct" runat="server" onselectedindexchanged="dlProductView_Select"
                datakeyfield="product_id">
	            <ItemTemplate> 
	               <li>$<%# DataBinder.Eval(Container.DataItem, "unit_price") %> <asp:LinkButton id="product_no" Text='<%# DataBinder.Eval(Container.DataItem, "product_name") %>' CommandName="Select" runat="server" /></li>
	            </ItemTemplate>
            </asp:datalist>
            </ul>
            <!-- product template -->
            <div class="product">
                <asp:datalist id="dlProductView" runat="server">
                <ItemTemplate> 
                   <h4><%# DataBinder.Eval(Container.DataItem, "product_name") %></h4>
                   <asp:Button runat="server" PostBackUrl="~/addcart.aspx" Text="Add to Cart" />
                   <input class="submit" type="submit" value="Add to Cart" />
                    <div><span class="price">$<%# DataBinder.Eval(Container.DataItem, "unit_price") %></span><%# DataBinder.Eval(Container.DataItem, "product_no") %></div>
                    <div>Year:<%# DataBinder.Eval(Container.DataItem, "year") %></div>
                    <div><%# DataBinder.Eval(Container.DataItem, "rental_type") %> Rental</div>
                    <label for="quantity">Quantity:<input type="text" name="quantity" size="2" /></label>
                    <input type="hidden" name="product_id" value="<%# DataBinder.Eval(Container.DataItem, "product_id") %>">							
                </ItemTemplate>
                </asp:datalist>
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
</form>
</body>
</html>