<%@ page import="grails.converters.deep.JSON; br.gov.go.saude.hugo.ambulancia.Viagem" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title><g:message code="viagem.create" default="Create Viagem"/></title>
  <script type="text/javascript">
    $(document).ready(function() {
      $('#dataSaida').datepicker({
        constrainInput: true,
        defaultDate: new Date(${viagem?.dataSaida.time}),
        minDate: new Date(${hoje.time}),

        showOn: 'button',
        buttonImageOnly: true,
        buttonImage: "${createLinkTo(dir: 'css/custom-theme/images', file: 'icons-mini-calendar.gif')}"
      });
    });
  </script>

  <style type="text/css">
  div.ui-datepicker {
    font-size: 14px;
  }
  </style>

  <script type="text/javascript">
    $(document).ready(function() {
      $('#horaSaida').timeEntry({
        show24Hours: true,
        spinnerImage: "${createLinkTo(dir: 'css', file: 'spinnerDefault.png')}"
      });

    });
  </script>

  <script type="text/javascript" src="${resource(dir: 'js', file: 'lista-paradas.js')}"></script>

  <script type="text/javascript">
    var items = new Ambulancia.FieldSetList({ renderTo: 'paradas' });

    function adicionePaciente() {
      items.adicione(Ambulancia.FieldSetList.TiposParadas['br.gov.go.saude.hugo.ambulancia.ParadaPaciente']);
    }

    function adicioneServicos() {
      items.adicione(Ambulancia.FieldSetList.TiposParadas['br.gov.go.saude.hugo.ambulancia.ParadaServicos']);
    }

    var paradas = ${viagem?.paradas as JSON};

    Ext.onReady(function() {
      Ext.QuickTips.init();

      for (var i = 0; i < paradas.length; i++) {
        var parada = paradas[i];
        items.adicione(Ambulancia.FieldSetList.TiposParadas[parada['class']], parada);
      }
    });

  </script>
  %{--<script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'paciente-editor.js')}"></script>--}%

</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home"/></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="viagem.list" default="Viagem List"/></g:link></span>
</div>
<div class="body">
  <h1><g:message code="viagem.create" default="Create Viagem"/></h1>
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:hasErrors bean="${viagem}">
    <div class="errors">
      <g:renderErrors bean="${viagem}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">

  %{--<g:each var="paciente" in="${viagem?.pacientes}" status="i">--}%
  %{--<g:hiddenField name="pacientes[${i}]" value="${paciente}"/>--}%
  %{--</g:each>--}%

    <div class="dialog">
      <table>
        <tbody id="main">

        <tr class="prop">
          <td valign="top" class="name">
            <label for="motorista"><g:message code="viagem.motorista" default="Motorista"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: viagem, field: 'motorista', 'errors')}">
            <g:select name="motorista.id" from="${motoristas}" optionKey="id" value="${viagem?.motorista?.id}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="ambulancia"><g:message code="viagem.ambulancia" default="Ambulancia"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: viagem, field: 'ambulancia', 'errors')}">
            <g:select name="ambulancia.id" from="${ambulancias}" optionKey="id" value="${viagem?.ambulancia?.id}"/>

          </td>
        </tr>


        <tr class="prop">
          <td valign="top" class="name">
            <label for="dataSaida"><g:message code="viagem.dataSaida" default="Data Saida"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: viagem, field: 'dataSaida', 'errors')}">
            <input id="dataSaida" name="dataSaida" type="text" value="${formatDate(date: viagem?.dataSaida, formatName: 'default.date.format')}" readonly="readonly">
            %{--<input type="text" readonly="readonly" id="dataSaida" name="dataSaida"--}%
            %{--value="${formatDate(date: viagem?.horaSaida, format: 'dd/MM/yyyy')}" />--}%

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="horaSaida"><g:message code="viagem.horaSaida" default="Hora Saida"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: viagem, field: 'horaSaida', 'errors')}">
            <input id="horaSaida" name="horaSaida" type="text" value="${formatDate(date: viagem?.horaSaida, formatName: 'default.time.format')}"/>
            %{--<g:datePicker name="horaSaida" value="${viagem?.horaSaida}"  />--}%

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="kmSaida"><g:message code="viagem.kmSaida" default="Km Saida"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: viagem, field: 'kmSaida', 'errors')}">
            <g:textField name="kmSaida" value="${viagem?.kmSaida}"/>

          </td>
        </tr>

        %{--<tr class="prop">--}%
        %{--<td valign="top" class="name">--}%
        %{--<label for="horaRetorno"><g:message code="viagem.horaRetorno" default="Hora Retorno" />:</label>--}%
        %{--</td>--}%
        %{--<td valign="top" class="value ${hasErrors(bean: viagem, field: 'horaRetorno', 'errors')}">--}%
        %{--<g:datePicker name="horaRetorno" value="${viagem?.horaRetorno}" noSelection="['': '']" />--}%

        %{--</td>--}%
        %{--</tr>--}%
        %{----}%
        %{--<tr class="prop">--}%
        %{--<td valign="top" class="name">--}%
        %{--<label for="kmRetorno"><g:message code="viagem.kmRetorno" default="Km Retorno" />:</label>--}%
        %{--</td>--}%
        %{--<td valign="top" class="value ${hasErrors(bean: viagem, field: 'kmRetorno', 'errors')}">--}%
        %{--<g:textField name="kmRetorno" value="${fieldValue(bean: viagem, field: 'kmRetorno')}" />--}%

        %{--</td>--}%
        %{--</tr>--}%

        %{--<tr class="prop">--}%
        %{--<td valign="top" class="name">--}%
        %{--<label for="destino"><g:message code="viagem.destino" default="Destino"/>:</label>--}%
        %{--</td>--}%
        %{--<td valign="top" class="value ${hasErrors(bean: viagem, field: 'destino', 'errors')}">--}%
        %{--<g:textField name="destino" value="${fieldValue(bean: viagem, field: 'destino')}"/>--}%

        %{--</td>--}%
        %{--</tr>--}%

        <tr class="prop">
          <td valign="top" class="name">
            <label for="paradas"><g:message code="viagem.paradas" default="Paradas"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: viagem, field: 'paradas', 'errors')} extjs">
            <a href="#" onclick="adicionePaciente()">Incluir paciente</a>
            <a href="#" onclick="adicioneServicos()">Incluir serviços</a>
            <div id="paradas"></div>
          </td>
        </tr>

        %{--<tr class="prop">--}%
          %{--<td valign="top" class="value ${hasErrors(bean: viagem, field: 'paradas', 'errors')} extjs" colspan="2">--}%
            %{--<div id="paradas"></div>--}%
          %{--</td>--}%
        %{--</tr>--}%

        <tr class="prop">
          <td valign="top" class="name">
            <label for="observacoes"><g:message code="viagem.observacoes" default="Observacoes"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: viagem, field: 'observacoes', 'errors')}">
            <g:textArea name="observacoes" value="${fieldValue(bean: viagem, field: 'observacoes')}"/>

          </td>
        </tr>

        %{--<tr class="prop">--}%
        %{--<td valign="top" class="name">--}%
        %{--<label for="retornou"><g:message code="viagem.retornou" default="Retornou" />:</label>--}%
        %{--</td>--}%
        %{--<td valign="top" class="value ${hasErrors(bean: viagem, field: 'retornou', 'errors')}">--}%
        %{--<g:checkBox name="retornou" value="${viagem?.retornou}" />--}%

        %{--</td>--}%
        %{--</tr>--}%

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'viagem.save', 'default': 'Create')}"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
