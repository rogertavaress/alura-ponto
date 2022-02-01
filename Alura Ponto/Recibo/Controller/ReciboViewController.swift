//
//  ReciboViewController.swift
//  Alura Ponto
//
//  Created by Ândriu Felipe Coelho on 22/09/21.
//

import UIKit

class ReciboViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var escolhaFotoView: UIView!
    @IBOutlet weak var reciboTableView: UITableView!
    @IBOutlet weak var fotoPerfilImageView: UIImageView!
    @IBOutlet weak var escolhaFotoButton: UIButton!
    
    // MARK: - Atributos
    
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configuraTableView()
        configuraViewFoto()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reciboTableView.reloadData()
    }
    
    // MARK: - Class methods
    
    func configuraViewFoto() {
        escolhaFotoView.layer.borderWidth = 1
        escolhaFotoView.layer.borderColor = UIColor.systemGray2.cgColor
        escolhaFotoView.layer.cornerRadius = escolhaFotoView.frame.width/2
        escolhaFotoButton.setTitle("", for: .normal)
    }
    
    func configuraTableView() {
        reciboTableView.dataSource = self
        reciboTableView.delegate = self
        reciboTableView.register(UINib(nibName: "ReciboTableViewCell", bundle: nil), forCellReuseIdentifier: "ReciboTableViewCell")
    }
    
    // MARK: - IBActions
    
    @IBAction func escolherFotoButton(_ sender: UIButton) {
        // TO DO: Abrir biblioteca de fotos
    }
}

extension ReciboViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Secao.shared.listaDeRecibos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReciboTableViewCell", for: indexPath) as? ReciboTableViewCell else {
            fatalError("erro ao criar ReciboTableViewCell")
        }
        
        let recibo = Secao.shared.listaDeRecibos[indexPath.row]
        cell.configuraCelula(recibo)
        cell.delegate = self
        cell.deletarButton.tag = indexPath.row
        
        return cell
    }
}

extension ReciboViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ReciboViewController: ReciboTableViewCellDelegate {
    func deletarRecibo(_ index: Int) {
        Secao.shared.listaDeRecibos.remove(at: index)
        reciboTableView.reloadData()
    }
}
