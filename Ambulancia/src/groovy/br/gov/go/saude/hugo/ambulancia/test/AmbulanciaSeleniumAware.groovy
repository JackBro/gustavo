package br.gov.go.saude.hugo.ambulancia.test

import grails.plugins.selenium.SeleniumAware
import br.gov.go.saude.hugo.ambulancia.utilitario.Ambiente
import br.gov.go.saude.hugo.ambulancia.Motorista
import br.gov.go.saude.hugo.ambulancia.Ambulancia
import br.gov.go.saude.hugo.ambulancia.Viagem
import br.gov.go.saude.hugo.ambulancia.GerenciamentoGrupoService
import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.codehaus.groovy.grails.commons.GrailsApplication

/**
 * Created by IntelliJ IDEA.
 * User: gustavosousa
 * Date: 23/12/2010
 * Time: 09:02:37
 * To change this template use File | Settings | File Templates.
 */
class AmbulanciaSeleniumAware extends SeleniumAware {
    void login() {
        login('usuario', '12345')
    }

    void login(String usuario, String senha) {
        inicio()

        assertEquals("Login", selenium.getTitle())
        selenium.type("username", usuario)
        selenium.type("password", senha)
        selenium.click("//input[@value='Login']")
        selenium.waitForPageToLoad()
    }

    void logout() {
        selenium.click("link=Sair")
        selenium.waitForPageToLoad()
        assertEquals("Login", selenium.getTitle())
    }

    void inicio() {
        selenium.open("/${Ambiente.instancia.appName}/")
        selenium.waitForPageToLoad()
    }

    void registreUsuario(String usuario, String senha, String grupo) {
        GrailsApplication application = ApplicationHolder.application
        GerenciamentoGrupoService gerenciamentoGrupoService = application.mainContext.gerenciamentoGrupoService
        gerenciamentoGrupoService.registreUsuario(usuario, senha, grupo)
    }

    void carregueBanco() {
        registreUsuario('usuario', '12345', 'ROLE_USER')

        assertEquals 0, Viagem.list().size()

//        Motorista.withTransaction {
            Motorista elias = new Motorista(nome: 'Elias Coelho', telefone: '2222-2222')
            elias.save()

            Motorista zeze = new Motorista(nome: 'Zeze')
            zeze.save()

            Ambulancia amb976 = new Ambulancia(prefixo: '976', placa: 'NKW-6031')
            amb976.save()

            Ambulancia amb1008 = new Ambulancia(prefixo: '1008', placa: 'NKW-8091')
            amb1008.save()

            Ambulancia amb1010 = new Ambulancia(prefixo: '1010', placa: 'NKV-4401', disponivel: false)
            amb1010.save()
//        }
    }

    void limpeBanco() {
//         Motorista.withTransaction {
             Viagem.list()*.delete()
             Motorista.list()*.delete()
             Ambulancia.list()*.delete()
//         }
    }
}
