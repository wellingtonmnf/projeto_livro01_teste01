public with sharing class ContaBancaria {

    public String nomeTitular;
    public Decimal saldo;
    public Integer numeroConta;

    public ContaBancaria() {

    }

    public String getNomeTitular(){
        return this.nomeTitular;
    }

    public Decimal getSaldo(){
        return this.saldo;
    }
}