const host = 'https://loyalistresearchnet.lib.unb.ca'
describe('Loyalist Research Network', {baseUrl: host, groups: ['sites']}, () => {

  context('Front page', {baseUrl: host}, () => {
    beforeEach(() => {
      cy.visit('/')
      cy.title()
        .should('contain', 'The Loyalist Collection at UNB | The Loyalist Research Network')
    })

    specify('"News" block should be visible', () => {
      cy.get('#block-views-block-news-block-1')
        .should('be.visible')
    })

    specify('Navigation menu should contain item "The Loyalist Collection at UNB"', () => {
      cy.get('nav[role="navigation"] a')
        .contains('The Loyalist Collection at UNB')
        .its('0.href')
        .should('match', /\/node\/15/)
    });
  })

  context('The Loyalist Collection at UNB', {baseUrl: `${host}/node/15`}, () => {
    beforeEach(() => {
      cy.visit('/')
      cy.title()
        .should('contain', 'The Loyalist Collection at UNB | The Loyalist Research Network')
    })

    specify('Content should contain link to "www.lib.unb.ca/collections/loyalist"', () => {
      cy.get('article p a[href="http://www.lib.unb.ca/collections/loyalist/"]')
        .should('be.visible')
    });
  })

})
