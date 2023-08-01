it("There is products on the page", () => {
  cy.get(".products article").should("be.visible");
});