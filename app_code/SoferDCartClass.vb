Imports System
Imports System.Data
Imports System.Data.OleDb
Imports System.Text
Imports System.Web
Imports System.Web.UI

Namespace SoferDCartNameSpace

    Public Class SoferDCartClass

        Inherits System.ComponentModel.Component
        Private ordline_sql As String
        Private ordhead_sql As String
        Private ordno_sql As String
        Private productno_sql As String
        Private productname_sql As String
        Private unitprice_sql As String
        Private quantity_sql As String
        Private firstname_sql As String
        Private lastname_sql As String
        Private email_sql As String
        Private address_sql As String
        Private city_sql As String
        Private state_sql As String
        Private zip_sql As String
        Private phone_sql As String
        Private cardtype_sql As String
        Private cardno_sql As String
        Private subtotal_sql As String
        Private tax_sql As String
        Private total_sql As String
        'Dim ConnStr As String = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & System.AppDomain.CurrentDomain.BaseDirectory() & "\students\SoferD\Project1\data\products.mdb;"
        Dim ConnStr As String = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & System.AppDomain.CurrentDomain.BaseDirectory() & "data\products.mdb;"

        Public Sub New()
            MyBase.New()
            ordline_sql = ""
            ordhead_sql = ""
            ordno_sql = ""
            productno_sql = ""
        End Sub

        Public Property SQLOrdLine() As String
            Get
                Return ordline_sql
            End Get
            Set(ByVal Value As String)
                ordline_sql = Value
            End Set
        End Property

        Public Property SQLOrdHead() As String
            Get
                Return ordhead_sql
            End Get
            Set(ByVal Value As String)
                ordhead_sql = Value
            End Set
        End Property

        Public Property ordNo() As String
            Get
                Return ordno_sql
            End Get
            Set(ByVal Value As String)
                ordno_sql = Value
            End Set
        End Property

        Public Property productNo() As String
            Get
                Return productno_sql
            End Get
            Set(ByVal Value As String)
                productno_sql = Value
            End Set
        End Property

        Public Property productname() As String
            Get
                Return productname_sql
            End Get
            Set(ByVal Value As String)
                productname_sql = Value
            End Set
        End Property

        Public Property unitprice() As String
            Get
                Return unitprice_sql
            End Get
            Set(ByVal Value As String)
                unitprice_sql = Value
            End Set
        End Property

        Public Property quantity() As Integer
            Get
                Return quantity_sql
            End Get
            Set(ByVal Value As Integer)
                quantity_sql = Value
            End Set
        End Property

        Private _line_total As String
        Public Property line_total() As String
            Get
                Return _line_total
            End Get
            Set(ByVal Value As String)
                _line_total = Value
            End Set
        End Property

        Public Property firstname() As String
            Get
                Return firstname_sql
            End Get
            Set(ByVal Value As String)
                firstname_sql = Value
            End Set
        End Property

        Public Property lastname() As String
            Get
                Return lastname_sql
            End Get
            Set(ByVal Value As String)
                lastname_sql = Value
            End Set
        End Property

        Public Property email() As String
            Get
                Return email_sql
            End Get
            Set(ByVal Value As String)
                email_sql = Value
            End Set
        End Property

        Public Property address() As String
            Get
                Return address_sql
            End Get
            Set(ByVal Value As String)
                address_sql = Value
            End Set
        End Property

        Public Property city() As String
            Get
                Return city_sql
            End Get
            Set(ByVal Value As String)
                city_sql = Value
            End Set
        End Property

        Public Property state() As String
            Get
                Return state_sql
            End Get
            Set(ByVal Value As String)
                state_sql = Value
            End Set
        End Property

        Public Property zip() As String
            Get
                Return zip_sql
            End Get
            Set(ByVal Value As String)
                zip_sql = Value
            End Set
        End Property

        Public Property phone() As String
            Get
                Return phone_sql
            End Get
            Set(ByVal Value As String)
                phone_sql = Value
            End Set
        End Property

        Public Property cardtype() As String
            Get
                Return cardtype_sql
            End Get
            Set(ByVal Value As String)
                cardtype_sql = Value
            End Set
        End Property

        Public Property cardno() As String
            Get
                Return cardno_sql
            End Get
            Set(ByVal Value As String)
                cardno_sql = Value
            End Set
        End Property

        Public Property subtotal() As String
            Get
                Return subtotal_sql
            End Get
            Set(ByVal Value As String)
                subtotal_sql = Value
            End Set
        End Property

        Public Property tax() As String
            Get
                Return tax_sql
            End Get
            Set(ByVal Value As String)
                tax_sql = Value
            End Set
        End Property

        Public Property total() As String
            Get
                Return total_sql
            End Get
            Set(ByVal Value As String)
                total_sql = Value
            End Set
        End Property

        Public Function getOrdNo() As String
            Dim strOrdNo As Single
            If HttpContext.Current.Request.Cookies("mycartno") Is Nothing Then
                Dim dbReadConn As OleDbConnection
                Dim dbReadConn1 As OleDbConnection
                Dim dbRead As OleDbDataReader
                Dim dbReadComm As OleDbCommand
                Dim dbReadUpdateComm As OleDbCommand
                Dim SQLUpdate As String
                Dim updateOrdNo As Single
                dbReadConn = New OleDbConnection(ConnStr)
                dbReadComm = New OleDbCommand("Select * from order_no", dbReadConn)
                dbReadConn.Open()
                dbRead = dbReadComm.ExecuteReader(CommandBehavior.CloseConnection)
                Do While dbRead.Read()
                    strOrdNo = dbRead.GetString(0)
                Loop
                dbReadConn1 = New OleDbConnection(ConnStr)
                updateOrdNo = strOrdNo + 1
                SQLUpdate = "update order_no set order_no = " & updateOrdNo.ToString
                dbReadUpdateComm = New OleDbCommand(SQLUpdate, dbReadConn1)
                dbReadConn1.Open()
                dbReadUpdateComm.ExecuteNonQuery()
                Dim CookieTo As New HttpCookie("mycartno", strOrdNo)
                HttpContext.Current.Response.AppendCookie(CookieTo)
            Else
                Dim CookieBack As HttpCookie
                CookieBack = HttpContext.Current.Request.Cookies("mycartno")
                strOrdNo = CookieBack.Value
            End If
            Return strOrdNo
        End Function

        Public Function addOrdLine() As OleDbDataReader
            Dim dbReadCheckConn As OleDbConnection
            Dim dbReadCheck As OleDbDataReader
            Dim dbReadCheckComm As OleDbCommand
            Dim SQLCheck As String
            Dim dbReadInsertConn As OleDbConnection
            Dim dbReadInsert As OleDbDataReader
            Dim dbReadInsertComm As OleDbCommand
            Dim SQLInsert As String
            dbReadCheckConn = New OleDbConnection(ConnStr)
            dbReadCheckConn.Open()
            SQLCheck = "select * from order_line where order_no = '" & ordNo.ToString() & "' and product_no = '" & productNo & "'"
            dbReadCheckComm = New OleDbCommand(SQLCheck, dbReadCheckConn)
            dbReadCheck = dbReadCheckComm.ExecuteReader(CommandBehavior.CloseConnection)
            SQLInsert = "insert into order_line (order_no, ord_date, product_no, quantity, product_name, unit_price) values('" & ordNo & "', '" & DateTime.Now & "', '" & productNo & "', '" & quantity & "', '" & productname & "', '" & unitprice & "')"
            dbReadInsertConn = New OleDbConnection(ConnStr)
            dbReadInsertConn.Open()
            dbReadInsertComm = New OleDbCommand(SQLInsert, dbReadInsertConn)
            dbReadInsert = dbReadInsertComm.ExecuteReader(CommandBehavior.CloseConnection)
            dbReadInsertConn.Close()
            dbReadInsert.Close()
        End Function

        Public Function getCart() As DataSet
            Dim dbReadViewCartConn As OleDbConnection
            Dim dbViewCartDA As OleDbDataAdapter
            Dim dbViewCartDS As New DataSet()
            Dim SQLViewCart As String
            SQLViewCart = "select * from order_line where order_no = '" & ordNo.ToString() & "'"
            dbReadViewCartConn = New OleDbConnection(ConnStr)
            dbViewCartDA = New OleDbDataAdapter(SQLViewCart, dbReadViewCartConn)
            dbViewCartDA.Fill(dbViewCartDS, "OrdLine")
            Return dbViewCartDS
        End Function

        Public Function getOrdHead() As DataSet
            Dim dbReadViewCartConn As OleDbConnection
            Dim dbViewCartDA As OleDbDataAdapter
            Dim dbViewCartDS As New DataSet()
            Dim SQLViewOrdHead As String
            SQLViewOrdHead = "select * from ord_head where order_no = '" & ordNo.ToString() & "'"
            dbReadViewCartConn = New OleDbConnection(ConnStr)
            dbViewCartDA = New OleDbDataAdapter(SQLViewOrdHead, dbReadViewCartConn)
            dbViewCartDA.Fill(dbViewCartDS, "OrdHead")
            Return dbViewCartDS
        End Function

        Public Function deleteOrdLine() As OleDbDataReader
            Dim dbReadDeleteConn As OleDbConnection
            Dim SQLDelete As String
            SQLDelete = "delete from order_line where order_no = '" & ordNo.ToString() & "' and product_no = '" & productNo & "'"
            dbReadDeleteConn = New OleDbConnection(ConnStr)
            Dim dbReadDeleteComm As OleDbCommand
            dbReadDeleteComm = New OleDbCommand(SQLDelete, dbReadDeleteConn)
            dbReadDeleteConn.Open()
            dbReadDeleteComm.ExecuteReader(CommandBehavior.CloseConnection)
            dbReadDeleteConn.Close()
        End Function

        Public Function updateOrdLine() As OleDbDataReader
            Dim dbReadDeleteConn As OleDbConnection
            Dim SQLDelete As String
            SQLDelete = "update order_line set quantity =" & quantity & " where order_no = '" & ordNo.ToString() & "' and product_no = '" & productNo & "'"
            dbReadDeleteConn = New OleDbConnection(ConnStr)
            Dim dbReadDeleteComm As OleDbCommand
            dbReadDeleteComm = New OleDbCommand(SQLDelete, dbReadDeleteConn)
            dbReadDeleteConn.Open()
            dbReadDeleteComm.ExecuteReader(CommandBehavior.CloseConnection)
            dbReadDeleteConn.Close()
        End Function

        Public Function addOrdHead() As OleDbDataReader
            calcTotals()
            Dim dbReadInsertConn As OleDbConnection
            Dim dbReadInsertComm As OleDbCommand
            Dim SQLInsert As String
            dbReadInsertConn = New OleDbConnection(ConnStr)
            SQLInsert = "insert into ord_head (order_no, firstname, lastname, email, address, city, state, zip, phone, cardtype, cardno) values ('" & ordNo & "', '" & firstname & "',  '" & lastname & "',  '" & email & "',  '" & address & "',  '" & city & "',  '" & state & "',  '" & zip & "',  '" & phone & "', '" & cardtype & "', '" & cardno & "', '" & subtotal & "', '" & tax & "', '" & total & "')"
            dbReadInsertComm = New OleDbCommand(SQLInsert, dbReadInsertConn)
            dbReadInsertConn.Open()
            dbReadInsertComm.ExecuteNonQuery()
            dbReadInsertConn.Close()
        End Function

        Private Sub calcTotals()
            Dim dbReadConn As OleDbConnection = New OleDbConnection(ConnStr)
            Dim dbRead As OleDbDataReader
            Dim dbReadComm As OleDbCommand

            dbReadComm = New OleDbCommand("SELECT SUM(`unit_price` * `quantity`) AS subtotal FROM order_line where order_no = '" & ordNo & "'", dbReadConn)
            dbReadConn.Open()
            dbRead = dbReadComm.ExecuteReader(CommandBehavior.CloseConnection)
            Do While dbRead.Read()
                subtotal = dbRead.GetString(0)
            Loop
            If state.Equals("CA") Then
                tax = "1.0875"
            Else
                tax = "1"
            End If
            total = tax * subtotal
        End Sub

    End Class
End Namespace