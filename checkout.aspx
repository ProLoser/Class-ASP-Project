<%@ Import Namespace="SoferDProductNameSpace" %>
<%@ Import Namespace="SoferDCartNameSpace" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Web.Mail" %>

<script language="VB" runat="server">
    Dim objCart As SoferDCartClass
    Dim objProduct As SoferDProductClass
    Dim objDS As New DataSet()
    Public strOrdNo As String
	
    Sub SendOrder(ByVal sender As System.Object, ByVal e As System.EventArgs)
        objProduct = New SoferDProductClass()
        objCart = New SoferDCartClass()
        strOrdNo = objCart.getOrdNo()
        objCart.ordNo = strOrdNo
        objCart.firstname = firstname.Text
        objCart.lastname = lastname.Text
        objCart.email = email.Text
        objCart.address = address.Text
        objCart.city = city.Text
        objCart.state = state.SelectedItem.Value
        objCart.zip = zip.Text
        objCart.phone = phone.Text
        objCart.cardtype = cardtype.SelectedItem.Value
        objCart.cardno = cardno.Text
        objCart.addOrdHead()
        Dim myMessage As New MailMessage
        Dim myMail As SmtpMail
        Dim strEmail As String
        Dim message As String
        strEmail = email.Text
        message = " Dear " + firstname.Text + " " + lastname.Text + ":"
        message = "\nYour Order"
        'objCart.getCart.Tables
        message = "\nWas purchased on the following Card"
        message = "\n" & objCart.cardtype & ": " & objCart.cardno
        message = "\n" & objCart.address
        message = "\n" & objCart.city & ", " & objCart.state & " " & objCart.zip
        myMessage.From = ("djsofer@csupomona.edu")
        myMessage.To = strEmail
        myMessage.Subject = "Thank you for your order! #" + objCart.ordNo
        myMessage.Body = message
        myMail.SmtpServer = "smtp.csupomona.edu"
        myMail.Send(myMessage)
        Response.Redirect("thankyou.aspx")
    End Sub
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>DJ's Shopping Cart</title>
    <link type="text/css" href="layout.css" rel="Stylesheet" />
</head>
<body>
    <form id="Form1" runat="server">
    <div id="container">
        <div id="header">
            <h2>
                DJ's Shopping Cart <span>Limit 1 Epic per customer</span>
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
                <div id="checkout">
                    <h1>
                        Checkout</h1>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="First name is required."
                        ControlToValidate="firstname"></asp:RequiredFieldValidator>
                    <label>
                        First Name:</label>
                    <asp:TextBox ID="firstname" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Last name is required."
                        ControlToValidate="lastname"></asp:RequiredFieldValidator>
                    <label>
                        Last Name:</label>
                    <asp:TextBox ID="lastname" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Email is required."
                        ControlToValidate="email" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Email format invalid."
                        ControlToValidate="email"  ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    <label>
                        Email:</label>
                    <asp:TextBox ID="email" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Address is required."
                        ControlToValidate="address"></asp:RequiredFieldValidator>
                    <label>
                        Address:</label>
                    <asp:TextBox ID="address" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="City is required."
                        ControlToValidate="city"></asp:RequiredFieldValidator>
                    <label>
                        City:</label>
                    <asp:TextBox ID="city" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="State is required."
                        ControlToValidate="state"></asp:RequiredFieldValidator>
                    <label>
                        State:</label>
                    <asp:DropDownList ID="state" runat="server">
                        <asp:ListItem Value="">-- Choose --</asp:ListItem>
                        <asp:ListItem Value="AL">Alabama</asp:ListItem>
                        <asp:ListItem Value="AK">Alaska</asp:ListItem>
                        <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                        <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                        <asp:ListItem Value="CA">California</asp:ListItem>
                        <asp:ListItem Value="CO">Colorado</asp:ListItem>
                        <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                        <asp:ListItem Value="DC">District of Columbia</asp:ListItem>
                        <asp:ListItem Value="DE">Delaware</asp:ListItem>
                        <asp:ListItem Value="FL">Florida</asp:ListItem>
                        <asp:ListItem Value="GA">Georgia</asp:ListItem>
                        <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                        <asp:ListItem Value="ID">Idaho</asp:ListItem>
                        <asp:ListItem Value="IL">Illinois</asp:ListItem>
                        <asp:ListItem Value="IN">Indiana</asp:ListItem>
                        <asp:ListItem Value="IA">Iowa</asp:ListItem>
                        <asp:ListItem Value="KS">Kansas</asp:ListItem>
                        <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                        <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                        <asp:ListItem Value="ME">Maine</asp:ListItem>
                        <asp:ListItem Value="MD">Maryland</asp:ListItem>
                        <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                        <asp:ListItem Value="MI">Michigan</asp:ListItem>
                        <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                        <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                        <asp:ListItem Value="MO">Missouri</asp:ListItem>
                        <asp:ListItem Value="MT">Montana</asp:ListItem>
                        <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                        <asp:ListItem Value="NV">Nevada</asp:ListItem>
                        <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                        <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                        <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                        <asp:ListItem Value="NY">New York</asp:ListItem>
                        <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                        <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                        <asp:ListItem Value="OH">Ohio</asp:ListItem>
                        <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                        <asp:ListItem Value="OR">Oregon</asp:ListItem>
                        <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                        <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                        <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                        <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                        <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                        <asp:ListItem Value="TX">Texas</asp:ListItem>
                        <asp:ListItem Value="UT">Utah</asp:ListItem>
                        <asp:ListItem Value="VT">Vermont</asp:ListItem>
                        <asp:ListItem Value="VA">Virginia</asp:ListItem>
                        <asp:ListItem Value="WA">Washington</asp:ListItem>
                        <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                        <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                        <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Zip is required."
                        ControlToValidate="zip" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Zip code is invalid."
                        ControlToValidate="zip" ValidationExpression="^((\d{5}-\d{4})|(\d{5})|([A-Z]\d[A-Z]\s\d[A-Z]\d))$"></asp:RegularExpressionValidator>
                    <label>
                        Zip:</label>
                    <asp:TextBox ID="zip" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Phone is required."
                        ControlToValidate="phone" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Phone number is invalid."
                        ControlToValidate="phone" ValidationExpression="^(1\s*[-\/\.]?)?(\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(([xX]|[eE][xX][tT])\.?\s*(\d+))*$"></asp:RegularExpressionValidator>
                    <label>
                        Phone:</label>
                    <asp:TextBox ID="phone" runat="server"></asp:TextBox>
                    <br />
                    <label>
                        Card Type:</label>
                    <asp:DropDownList ID="cardtype" runat="server">
                        <asp:ListItem Value="Visa" Selected="True">Visa</asp:ListItem>
                        <asp:ListItem Value="Master">Master</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Card No is required."
                        ControlToValidate="cardno"></asp:RequiredFieldValidator>
                    <label>
                        Card No:</label>
                    <asp:TextBox ID="cardno" runat="server"></asp:TextBox>
                    <br />
                    <asp:Button ID="send" OnClick="SendOrder" Text="Checkout" runat="server"></asp:Button>
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
    </form>
</body>
</html>
