describe('Product Details', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('navigtes from home page to product page details page when product image is clicked', () => {
    cy.get('.products article').first().find('a').click();

    cy.url().should('include', '/products/')

    cy.get('.product-detail').should('be.visible')
  })
})