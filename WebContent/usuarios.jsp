<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${!loginBean.autenticado || !loginBean.usuario.administrador}">
	<c:redirect url="Controladora?action=index"/>
</c:if>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Usu�rios</title>
        <link rel="stylesheet" type="text/css" href="style.css" />
        <script type="text/javascript" src="js/boxOver.js"></script>
        <script src="js/jquery-2.0.2.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="jquery-ui.min.css" />
    </head>
    <body>

       <div id="main_container">

             <%@ include file="header.jsp"%>       

            <div id="main_content">
               
        
 <%@ include file="menu.jsp"%>       
 <%@ include file="menuEsquerda.jsp"%>    

                <div class="center_content">

                    <div class="center_title_bar">
                       Usu�rios
                    </div>
					
					          <table border='1' style="font-size:8;">
                                <tr><td>Id</td><td>Nome</td><td>Email</td><td>CPF</td><td>CNPJ</td><td>Telefone 1</td><td>Telefone 2</td><td></td></tr>

								 <c:forEach items="${listaUsuarios}" var="usuario">      
								 <tr><td>${usuario.id}</td><td>${usuario.nome}</td><td>${usuario.email}</td><td>${usuario.cpf}</td><td>${usuario.cnpj}</td><td>${usuario.telefone1}</td><td>${usuario.telefone2}</td><td><a href="Controladora?action=admin&sub=usuario&id=${usuario.id}">Editar</a></td></tr>
        	           			 </c:forEach>
                             </table>

					
     
               </div><!-- center -->
            
                
 <%@ include file="menuDireita.jsp"%>   
     
            </div><!-- main index -->

           
            
 <%@ include file="footer.html"%>       
        </div>
    </body>
</html>
