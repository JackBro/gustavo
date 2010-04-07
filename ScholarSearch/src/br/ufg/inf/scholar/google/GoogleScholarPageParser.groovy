package br.ufg.inf.references.google

import br.ufg.inf.references.PageParser
import org.w3c.dom.Document
import org.w3c.dom.NodeList
import javax.xml.xpath.XPath
import javax.xml.xpath.XPathFactory
import javax.xml.xpath.XPathConstants

/**
 * Created by IntelliJ IDEA.
 * User: gustavo
 * Date: 07/04/2010
 * Time: 16:09:30
 * To change this template use File | Settings | File Templates.
 */
class GoogleScholarPageParser implements PageParser {
    private XPath xpath = XPathFactory.newInstance().newXPath()

    NodeList getResults(Document document) {
        xpath.evaluate("html//div[@class='gs_r']", document, XPathConstants.NODESET)
    }
}
