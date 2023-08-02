describe('add to cart', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('add a product to the cart and updates the cart count', () => {
    cy.get('.nav-item.end-0').contains('My Cart (0)');

    cy.get('.add-to-cart-btn').first().click({force: true});

    cy.get('.nav-item.end-0').contains('My Cart (1)')
  });
});