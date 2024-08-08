public with sharing class Oportunidades {

    public List<Opportunity> oportunidades { get; set; }

    public Oportunidades() {

        oportunidades = [SELECT Name, Type, Amount FROM Opportunity WHERE Amount > 100000];
    }

    public void imprimirOportunidades() {

        for (Opportunity opp : oportunidades) {
           System.debug(opp.Name + ' - ' + opp.Type + ' - ' + opp.Amount);
        }
    }

}