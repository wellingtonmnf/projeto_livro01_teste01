public with sharing class Produto {

    public String nome;
    public Double preco;
    public Integer quantidadeEstoque;

    public Produto() {

    }

    public String getNome(){
        return this.nome;
    }

    public Double getPreco(){
        return this.preco;
    }
}