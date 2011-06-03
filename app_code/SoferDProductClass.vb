Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Data.OleDb
Imports System.Text
Imports System.Web
Imports System.Web.HttpServerUtility
Imports System.Web.UI
Imports System.IO

Namespace SoferDProductNameSpace

    Public Class SoferDProductClass

        Inherits System.ComponentModel.Component
        Private ls_sql As String
        Private ps_sql As String
        Private maincat_sql As String
        Private subcat_sql As String
        Private product_sql As String
        'Dim ConnStr As String = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & System.AppDomain.CurrentDomain.BaseDirectory() & "\students\SoferD\Project1\data\products.mdb;"
        Dim ConnStr As String = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & System.AppDomain.CurrentDomain.BaseDirectory() & "data\products.mdb;"
        Public Sub New()
            MyBase.New()
            ls_sql = ""
            ps_sql = ""
            maincat_sql = ""
            subcat_sql = ""
            product_sql = ""
        End Sub

        Public Property strMainCatNo() As String
            Get
                Return maincat_sql
            End Get
            Set(ByVal Value As String)
                maincat_sql = Value
            End Set
        End Property

        Public Property strSubCatID() As String
            Get
                Return subcat_sql
            End Get
            Set(ByVal Value As String)
                subcat_sql = Value
            End Set
        End Property

        Public Property strProductID() As String
            Get
                Return product_sql
            End Get
            Set(ByVal Value As String)
                product_sql = Value
            End Set
        End Property

        ' all methods

        Public Function getAllMainCat() As OleDbDataReader
            Dim dbReadConn As OleDbConnection
            Dim SQL As String
            SQL = "SELECT * FROM main_cat order by cint(main_cat_no)"
            dbReadConn = New OleDbConnection(ConnStr)
            Dim dbRead As OleDbDataReader
            Dim dbReadComm As OleDbCommand
            dbReadComm = New OleDbCommand(SQL, dbReadConn)
            dbReadConn.Open()
            dbRead = dbReadComm.ExecuteReader(CommandBehavior.CloseConnection)
            Return dbRead
        End Function

        Public Function getAllSubCat() As OleDbDataReader
            Dim dbReadConn As OleDbConnection
            Dim SQL As String
            SQL = "SELECT * FROM sub_cat where main_cat_no = '" & strMainCatNo & "' order by cint(sub_cat_no)"
            dbReadConn = New OleDbConnection(ConnStr)
            Dim dbRead As OleDbDataReader
            Dim dbReadComm As OleDbCommand
            dbReadComm = New OleDbCommand(SQL, dbReadConn)
            dbReadConn.Open()
            dbRead = dbReadComm.ExecuteReader(CommandBehavior.CloseConnection)
            Return dbRead
        End Function

        Public Function getSubProduct() As OleDbDataReader
            Dim dbReadConn As OleDbConnection
            Dim SQL As String
            SQL = "SELECT * FROM products where sub_cat_id = " & CInt(strSubCatID)
            dbReadConn = New OleDbConnection(ConnStr)
            Dim dbRead As OleDbDataReader
            Dim dbReadComm As OleDbCommand
            dbReadComm = New OleDbCommand(SQL, dbReadConn)
            dbReadConn.Open()
            dbRead = dbReadComm.ExecuteReader(CommandBehavior.CloseConnection)
            Return dbRead
        End Function

        Public Function getTheProduct() As OleDbDataReader
            Dim dbReadConn As OleDbConnection
            Dim SQL As String
            SQL = "SELECT * FROM products where product_id = " & CInt(strProductID)
            dbReadConn = New OleDbConnection(ConnStr)
            Dim dbRead As OleDbDataReader
            Dim dbReadComm As OleDbCommand
            dbReadComm = New OleDbCommand(SQL, dbReadConn)
            dbReadConn.Open()
            dbRead = dbReadComm.ExecuteReader(CommandBehavior.CloseConnection)
            Return dbRead
        End Function

    End Class
End Namespace