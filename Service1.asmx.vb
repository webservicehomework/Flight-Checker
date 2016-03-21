Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel
Imports System.Data.SqlClient


' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
'<System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://localhost")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class Service1
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function GetData(ByVal FlightNumber As String) As String

        'connect to database
        Dim Catalog As String = "Data Source=BigRock\CourierComplete;Initial Catalog=FlightInformation;Persist Security Info=True;User ID=yycreadonly;Password=assignment"
        'prepare query, get data from FlightData table acoording to flight_number
        Dim SqlString As String = "SELECT * from dbo.FlightData WHERE flight_number = '" + FlightNumber + "'"
        Dim Connection As SqlConnection = New SqlConnection(Catalog)
        Dim Command As SqlCommand = New SqlCommand(SqlString, Connection)
        Dim DataReader As SqlDataReader

        '-- Open Database Connection, And Initialize DataReader --'
        Connection.Open()


        Try
            'execute reader'
            DataReader = Command.ExecuteReader

            'if no rows, alert user and exit
            If DataReader.HasRows = False Then
                Return "Sorry no flights matched our records"
            End If

            'craft return string
            Dim retStr As String = ""

            'respective id's of returned data from query
            Dim gate_id As Integer
            Dim destination_airport_id As Integer
            Dim takeoff_airport_id As Integer
            Dim departure_time As String
            Dim airline_id As Integer

            'read info from query
            DataReader.Read()

            'fill pertinent data from result
            gate_id = DataReader("gate_id")
            destination_airport_id = DataReader("destination_airport_id")
            takeoff_airport_id = DataReader("takeoff_airport_id")
            departure_time = DataReader("departure_time")
            airline_id = DataReader("airline_id")
            DataReader.Close()

            'get airline name from airline_id
            Dim airline_query As String = "select dbo.Airline.airline_name from dbo.Airline where airline_id = " + CStr(airline_id) + ""
            Dim acommand As SqlCommand = New SqlCommand(airline_query, Connection)
            DataReader = acommand.ExecuteReader
            DataReader.Read()
            Dim airline As String = DataReader("airline_name")
            DataReader.Close()

            'get gate name from gate_id
            Dim gate_query As String = "select dbo.Gate.gate_name from dbo.Gate where gate_id = " + CStr(gate_id)
            Dim gcommand As SqlCommand = New SqlCommand(gate_query, Connection)
            DataReader = gcommand.ExecuteReader
            DataReader.Read()
            Dim gate As String = DataReader("gate_name")
            DataReader.Close()

            'get takeoff airport name from takeoff airport_id 
            Dim takeoff_query As String = "select dbo.Airport.airport_name from dbo.Airport where airport_id = " + CStr(takeoff_airport_id)
            Dim tcommand As SqlCommand = New SqlCommand(takeoff_query, Connection)
            DataReader = tcommand.ExecuteReader
            DataReader.Read()
            Dim takeoff_airport As String = DataReader("airport_name")
            DataReader.Close()

            'get destination airport name from destination airport_id
            Dim destination_query As String = "select dbo.Airport.airport_name from dbo.Airport where airport_id = " + CStr(destination_airport_id)
            Dim dcommand As SqlCommand = New SqlCommand(destination_query, Connection)
            DataReader = dcommand.ExecuteReader
            DataReader.Read()
            Dim destination_airport As String = DataReader("airport_name")

            'prompt user with results
            retStr = retStr + "Your flight (" + FlightNumber + ") from " + takeoff_airport + " to " + destination_airport + " with " + airline + " is departing from gate " + gate + " at " + departure_time

            '-- Close Database Connection --'
            DataReader.Close()
            Connection.Close()

            Return retStr

        Catch soapex As Exception
            '-- Close Database Connection --'
            Connection.Close()
            Return "There was an error processing your request"
        End Try

        '-- Close Database Connection --'

    End Function

End Class