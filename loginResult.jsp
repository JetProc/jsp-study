<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>

//커넥터 파일을 불러오는 라이브러리
<%@ page import="java.sql.DriverManager" %> 

//데이터베이스에 연결하는 라이브러리
<%@ page import="java.sql.Connection" %> 

//데이터베이스에 SQL문을 전송하는 라이브러리
<%@ page import="java.sql.PreparedStatement" %> 

//데이터베이스의 결과값을 저장하는 라이브러리
<%@ page import="java.sql.ResultSet" %> 

//리스트 라이브러리
<%@ page import="java.util.ArrayList" %>

<%
    //앞선 페이지에서 보내준 값에 대한 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    //앞선 페이지에서 값 받아오기
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");
    
    //커넥터를 통해 데이터베이스를 탐색
    Class.forName("com.mysql.jdbc.Driver");

    //데이터베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/web","stageus","1234");

    //SQL 생성
    String sql = "SELECT * FROM account WHERE id=? AND pw=?;"; //sql 명령어 준비
    PreparedStatement query = connect.prepareStatement(sql); //만들어진 SQL을 전송 대기
    query.setString(1, idValue);
    query.setString(2, pwValue);


    //SQL 전송
    ResultSet result = query.executeQuery();

    //데이터 정제
    ArrayList idList = new ArrayList<String>();
    ArrayList pwList = new ArrayList<String>();

   

    //프론트엔드로 결과값 전송
    while(result.next()){
        String idData = "\""+result.getString(1)+"\"";
        String pwData = "\""+result.getString(2)+"\"";
        idList.add(idData);
        pwList.add(pwData);
    }
%>

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Document</title>
</head>
<body>
  <h1>로그인 결과 페이지</h1>
  <h2><%=idValue%></h2>
  <h2><%=pwValue%></h2>

  <script>
    //js에서 쓰기 쉬운 list의 형태로 값을 받아왔으니, for문이던 createElement던 사용해서 내가 요리
    var idList = <%=idList%>;
    var pwList = <%=pwList%>; 
    for(var i=0; i<idList.length; i++){
        console.log('id:',idList[i]+'/ pw:',pwList[i])
    }
  </script>
</body>