<%@ import Namespace="SoferDProductNameSpace" %>
<%@ import Namespace="SoferDCartNameSpace" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="VB" runat="server"> 
   Sub Page_Load(Source As Object, E As EventArgs) 
        Dim objProduct As SoferDProductClass = New SoferDProductClass()
        Dim objCart As SoferDCartClass = New SoferDCartClass()
		Dim dbRead As OleDbDataReader
		
		objProduct.strProductID = request.form.get("product_id")
		dbRead = objProduct.getTheProduct()
		If dbRead.Read() Then
		   objCart.productname = dbRead.Item("product_name")
			objCart.unitprice = dbRead.Item("unit_price") 
		End if
		
   	Dim strOrdNo As String = objCart.getOrdNo()
		objCart.OrdNo = strOrdNo
		objCart.productno = request.form.get("product_id")
	   objCart.quantity = request.form.get("quantity")
	   objCart.addOrdLine() 
	   Response.Redirect("mycart.aspx")
   End Sub
</script>
