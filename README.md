# ☕ Asicoffee App

Aplicativo mobile desenvolvido em Flutter com foco em **interatividade avançada, gerenciamento de estado e experiência do usuário**.

O app simula a gestão de um cardápio (como de uma cafeteria), permitindo **cadastro, visualização, favoritação e remoção de itens**, com navegação moderna e sincronização de dados em tempo real.

---

## 🚀 Funcionalidades

### 📋 Gestão de Cardápio
- Cadastro de novos itens via **Modal Bottom Sheet**
- Formulário com validações:
  - Nome obrigatório
  - Preço não pode ser negativo
- Inputs utilizados:
  - Texto (nome)
  - Numérico (preço)
  - Dropdown (categoria)
  - DatePicker (data de lançamento)

### 🗑️ Remoção de Itens
- Exclusão com gesto utilizando **Dismissible (arrastar para deletar)**

---

## 🧭 Navegação

- **Bottom Tabs**:
  - Cardápio Completo
  - Meus Favoritos

- **Drawer (Menu Lateral)**:
  - Filtros globais (ex: sem glúten)

- **Tela de Detalhes**:
  - Exibe informações completas do item
  - Recebe dados via argumentos de navegação

---

## ⭐ Favoritos

- Sistema de favoritação integrado
- Atualização em tempo real entre telas
- Sincronização automática entre:
  - Lista principal
  - Tela de detalhes
  - Aba de favoritos

---

## 🧠 Gerenciamento de Estado

Utiliza **Riverpod** para gerenciar o estado global da aplicação.

- Providers para:
  - Lista de produtos
  - Itens favoritados
- Substitui o uso de `setState` para melhor escalabilidade
- Garante consistência dos dados em toda a aplicação

---

## 🎨 Interface e Responsividade

- Suporte a **Dark Mode**
- Layout responsivo:
  - Adaptação com `LayoutBuilder` e widgets flexíveis
  - Funciona em diferentes orientações de tela

---

## 🛠️ Tecnologias Utilizadas

- Flutter
- Dart
- Riverpod

