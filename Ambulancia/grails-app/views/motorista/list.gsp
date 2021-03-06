<%@ page import="br.gov.go.saude.hugo.ambulancia.Motorista" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title><g:message code="motorista.list" default="Motorista List"/></title>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home"/></a></span>
  <span class="menuButton"><g:linkIfAccess class="create" action="create"><g:message code="motorista.new" default="New Motorista"/></g:linkIfAccess></span>
</div>
<div class="body">
  <h1><g:message code="motorista.list" default="Motorista List"/></h1>
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <div class="list">
    <table>
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Id" titleKey="motorista.id"/>

        <g:sortableColumn property="nome" title="Nome" titleKey="motorista.nome"/>

        <g:sortableColumn property="telefone" title="Telefone" titleKey="motorista.telefone"/>

      </tr>
      </thead>
      <tbody>
      <g:each in="${motoristaInstanceList}" status="i" var="motoristaInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:linkIfAccess action="show" id="${motoristaInstance.id}">${motoristaInstance.id}</g:linkIfAccess></td>

          <td>${fieldValue(bean: motoristaInstance, field: "nome")}</td>

          <td>${fieldValue(bean: motoristaInstance, field: "telefone")}</td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${motoristaInstanceTotal}"/>
  </div>
</div>
</body>
</html>
