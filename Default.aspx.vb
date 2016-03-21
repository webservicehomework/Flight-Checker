Partial Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click

        'initialize webservice 
        Dim test As service1.Service1 = New service1.Service1
        'initialize flightinfo textbox value
        Dim flightinfo As String

        Try
            'retrieve flight information from the FlightData table
            flightinfo = test.GetData(TextBox1.Text)
            'prompt user with results
            Label1.Text = flightinfo
        Catch soapex As Exception
            'prompt user if there is an error
            Label1.Text = soapex.ToString
        End Try
    End Sub



End Class