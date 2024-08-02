public with sharing class ListaDeCompras {

    public String nomeLista {get; set;}
    public List<String> itens {get; set;}

    public ListaDeCompras(String nomeLista) {
        this.nomeLista = nomeLista;
        this.itens = new List<String>();
    }

    public void adicionarItem(String nomeItem){
        this.itens.add(nomeItem);
    } 

    public void imprimirLista(){
        System.debug('Lista de Compras'+this.nomeLista+':');
        for (String item: this.itens){
            System.debug('-'+item);
        }
    }
}