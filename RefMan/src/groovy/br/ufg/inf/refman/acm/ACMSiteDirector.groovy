package br.ufg.inf.refman.acm

import br.ufg.inf.refman.SiteDirector
import br.ufg.inf.utils.url.QueryURI
import org.apache.log4j.Logger

/**
 * Created by IntelliJ IDEA.
 * User: gustavo
 * Date: 09/04/2010
 * Time: 11:50:45
 * To change this template use File | Settings | File Templates.
 */
class ACMSiteDirector implements SiteDirector {
    private static Logger log = Logger.getLogger(ACMSiteDirector)
    public List collectPages(String url, Closure closure) {
        List result = []
        int start = 1


        log.debug "URL: ${url}"
        QueryURI queryURI = new QueryURI(url)
        while (true) {
            queryURI.setQueryParam('start', start)
            //String url = "http://portal.acm.org/results.cfm?CFID=85171659&CFTOKEN=97314837&adv=1&COLL=ACM&DL=ACM&Go.x=48&Go.y=12&termzone=Title&allofem=${URLEncoder.encode(query)}&anyofem=&noneofem=&peoplezone=Name&people=&peoplehow=and&keyword=&keywordhow=AND&affil=&affilhow=AND&pubin=&pubinhow=and&pubby=&pubbyhow=OR&since_year=&before_year=&pubashow=OR&sponsor=&sponsorhow=AND&confdate=&confdatehow=OR&confloc=&conflochow=OR&isbnhow=OR&isbn=&doi=&ccs=&subj=&start=${start}"

            List itens = closure(queryURI.getURI())
            result.addAll(itens)
            if (itens.size() < 20)
                break

            start += 20
        }

        result
    }
}