it("There is products on the page", () => {
  cy.visit("/")
  cy.get(".products").should("be.visible");
});

it("There is 2 products on the page", () => {
  cy.get(".products article").should("have.length", 2);
});