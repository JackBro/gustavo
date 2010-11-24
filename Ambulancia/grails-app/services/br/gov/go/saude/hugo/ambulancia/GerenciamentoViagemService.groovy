package br.gov.go.saude.hugo.ambulancia

class GerenciamentoViagemService {
    AmbulanciaService ambulanciaService

    private Viagem obtenhaViagemNaoRetornou(Ambulancia ambulancia) {
        Viagem.findByAmbulanciaAndRetornou(ambulancia, false)
    }

    private Viagem obtenhaViagemNaoRetornou(Motorista motorista) {
        Viagem.findByMotoristaAndRetornou(motorista, false)
    }

    private void verifiqueAtributo(Viagem viagem, String atributo) {
        log.warn "Viagem inv�lida, '$atributo' em tr�nsito"

        if (!viagem.errors.hasErrors())
            viagem.validate()

//        if (!viagem.errors.hasFieldErrors(atributo))
        viagem.errors.rejectValue(atributo, 'unique')
    }

    boolean registreSaida(Viagem viagem) {
        if (obtenhaViagemNaoRetornou(viagem.ambulancia))
            verifiqueAtributo(viagem, 'ambulancia')

        if (obtenhaViagemNaoRetornou(viagem.motorista))
            verifiqueAtributo(viagem, 'motorista')

        if (viagem.kmSaida < ambulanciaService.obtenhaKmRetornoUltimaViagem(viagem.ambulancia)) {
            if (!viagem.errors.hasErrors())
                viagem.validate()

            if (!viagem.errors.hasFieldErrors('kmSaida'))
                viagem.errors.rejectValue('kmSaida', 'min.notmet')
        }

        !viagem.hasErrors() && viagem.save()
    }

    boolean registreRetorno(Viagem viagem) {
        !viagem.hasErrors() && viagem.save()
    }

    Date obtenhaMenorDataSaida() {
        
    }
}
