package br.ufg.inf.refman

import br.ufg.inf.utils.LevenshteinDistance
import br.ufg.inf.utils.Normalizer

/**
 * Created by IntelliJ IDEA.
 * User: gustavo
 * Date: 07/04/2010
 * Time: 11:02:45
 * To change this template use File | Settings | File Templates.
 */
class SearchResult {
    static constraints = {
        queryResult(nullable: false)
        title(nullable: false, blank: false)
        url(nullable: true)
        authorsString(nullable: false, blank: true)
        publicationName(nullable: true)
        publicationYear(nullable: true)
        html(nullable: false)
        study(nullable: true)
    }

    static belongsTo = QueryResult
    QueryResult queryResult
    Study study

    String title
    String url

    String authorsString = ''
    String publicationName
    Integer publicationYear

    static transients = [ 'normalizedTitle', 'authors', 'publication' ]

    public Publication getPublication() {
        new Publication(year: publicationYear, name: publicationName)
    }

    public void setPublication(Publication publication) {
        if (publication != null) {
            publicationYear = publication.year
            publicationName = publication.name
        }
    }

    int citationCount = -1

    String description
    List links = []
    String html

    public void setAuthors(List authors) {
        authorsString = authors.join(', ')
    }

    public List getAuthors() {
        authorsString.tokenize(',').collect { it.trim() }
    }

    public double calculateDistanceToLengthRation(SearchResult searchResult) {
        int distance = LevenshteinDistance.calcule(normalizedTitle, searchResult.normalizedTitle)

        distance / searchResult.normalizedTitle.length() + distance / normalizedTitle.length()
    }

    public String getNormalizedTitle() {
        Normalizer.normalize(title)
    }
    //String type
    public String toString() {
        "${title} - ${authorsString}"
    }

}
