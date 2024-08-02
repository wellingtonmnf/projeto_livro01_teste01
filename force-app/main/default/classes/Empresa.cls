public with sharing class Empresa {

    public Map<String,Double> funcionarios {get;set;}

    public Empresa() {
        this.funcionarios = new Map<String,Double>();
    }

    public void adicionarFuncionario(String nome, Double salario){
        this.funcionarios.put(nome, salario);
    }

    public void exibirFuncionario(){
        System.debug('Lista de funcionários e salários:');
        System.debug('---------------------------------');
        for (String nome : funcionarios.keySet()) {
            Double valor = funcionarios.get(nome);
            System.debug('Funcionário: '+nome+' | Salário: R$'+valor);
        }
    }
}
