compiler asciidoctor2pdf

let b:foldtext_strip_add_regex = '^=\+'

setl cole=3

nnoremap <buffer> <leader><leader>oo :AsciidoctorOpenRAW<CR>
nnoremap <buffer> <leader><leader>oh :AsciidoctorOpenHTML<CR>
nnoremap <buffer> <leader><leader>ox :AsciidoctorOpenDOCX<CR>
nnoremap <buffer> <leader><leader>op :AsciidoctorOpenPDF<CR>
nnoremap <buffer> <leader><leader>cp :Asciidoctor2PDF<CR>
nnoremap <buffer> <leader><leader>cx :Asciidoctor2DOCX<CR>
nnoremap <buffer> <leader><leader>ch :Asciidoctor2HTML<CR>
nnoremap <buffer> <leader><leader>p :AsciidoctorPasteImage<CR>

inorea <buffer> nbsp {nbsp}<C-R>=Eatchar('\s')<CR>
inorea <buffer> zwsp {zwsp}<C-R>=Eatchar('\s')<CR>
inorea <buffer> blnk {blank}<C-R>=Eatchar('\s')<CR>

inorea <buffer> enopt Maxim Kim<CR>
            \v0.1, =strftime("%Y-%m-%d") : Draft<CR>
            \:pdf-style: default<CR>
            \:doctype: article<CR>
            \:title-page:<CR>
            \:toc: left<CR>
            \:toclevels: 3<CR>
            \:sectnums:<CR>
            \:sectnumlevels: 4<CR>
            \:source-highlighter: rouge<CR>
            \:rouge-style: github<CR>
            \:!source-linenums-option:<CR>
            \:imagesdir: images<CR>
            \:chapter-signifier:<CR>
            \:icons: font<CR>
            \:autofit-option:<CR>
            \:experimental:<CR>
            \:compress:
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> ruopt Максим Ким<CR>
            \v0.1, =strftime("%Y-%m-%d") : Предварительный вариант<CR>
            \:pdf-style: default<CR>
            \:doctype: article<CR>
            \:title-page:<CR>
            \:toc: left<CR>
            \:toclevels: 3<CR>
            \:sectnums:<CR>
            \:sectnumlevels: 4<CR>
            \:source-highlighter: rouge<CR>
            \:rouge-style: github<CR>
            \:!source-linenums-option:<CR>
            \:imagesdir: images<CR>
            \:icons: font<CR>
            \:autofit-option:<CR>
            \:chapter-signifier: Раздел<CR>
            \:caution-caption: Внимание<CR>
            \:important-caption: Важно<CR>
            \ifdef::preface-title[:preface-title: Предисловие]<CR>
            \:note-caption: Примечание<CR>
            \:tip-caption: Подсказка<CR>
            \:warning-caption: Предупреждение<CR>
            \:figure-caption: Рисунок<CR>
            \:table-caption: Таблица<CR>
            \:example-caption: Пример<CR>
            \:toc-title: Содержание<CR>
            \:appendix-caption: Приложение<CR>
            \:last-update-label: Обновлено<CR>
            \:untitled-label: Без названия<CR>
            \:version-label: Версия<CR>
            \:experimental:<CR>
            \:compress:
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> atable [cols=".^1,.^2", options="header"]<CR>
            \\|=============================================================================<CR>
            \<CR>
            \\| <CR>
            \\| <CR>
            \<CR>
            \\| <CR>
            \\| <CR>
            \<CR>
            \\|=============================================================================
            \<Up><Up><Up><Up><Up><Up>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> anote [NOTE]<CR>
            \==============================================================================<CR><CR>
            \==============================================================================
            \<Up>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> awarn [WARNING]<CR>
            \==============================================================================<CR><CR>
            \==============================================================================
            \<Up>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> acau [CAUTION]<CR>
            \==============================================================================<CR><CR>
            \==============================================================================
            \<Up>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> aimpo [IMPORTANT]<CR>
            \==============================================================================<CR><CR>
            \==============================================================================
            \<Up>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> aex [example]<CR>
            \==============================================================================<CR><CR>
            \==============================================================================
            \<Up>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> atip [TIP]<CR>
            \==============================================================================<CR><CR>
            \==============================================================================
            \<Up>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> asrc [source]<CR>
            \------------------------------------------------------------------------------<CR><CR>
            \------------------------------------------------------------------------------
            \<Up>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> alit [literal]<CR>
            \..............................................................................<CR><CR>
            \..............................................................................
            \<Up>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> aside .Sidebar Note<CR>
            \******************************************************************************<CR><CR>
            \******************************************************************************
            \<Up>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> aquote [quote]<CR>
            \______________________________________________________________________________<CR><CR>
            \______________________________________________________________________________
            \<Up>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> averse [verse]<CR>
            \______________________________________________________________________________<CR><CR>
            \______________________________________________________________________________
            \<Up>
            \<C-R>=Eatchar('\s')<CR>


inorea <buffer> adiag [plantuml, diagram-name, svg]<CR>
            \....<CR>
            \skinparam monochrome false<CR>
            \skinparam shadowing true<CR>
            \skinparam dpi 100<CR>
            \skinparam backgroundcolor transparent<CR>
            \skinparam defaultFontName Noto Serif<CR>
            \<CR>
            \....<Up><C-R>=Eatchar('\s')<CR>
            \<C-R>=Eatchar('\s')<CR>

inorea <buffer> aerd [plantuml, erd-name, svg]<CR>
            \....<CR>
            \skinparam monochrome false<CR>
            \skinparam shadowing true<CR>
            \skinparam dpi 100<CR>
            \skinparam backgroundcolor transparent<CR>
            \skinparam defaultFontName Noto Serif<CR>
            \!define table(x) class x << (T,#ede7aa) >><CR>
            \!define view(x) class x << (V,lightblue) >><CR>
            \!define f(n,t) {field}n <color:gray>: t</color><CR>
            \!define string(n,size) {field}n <color:gray>: varchar(size)</color><CR>
            \<CR>
            \hide methods<CR>
            \hide stereotypes<CR>
            \<CR>
            \table(mdc.Party) {<CR>
            \f(**source_id**, **int**)<CR>
            \f(master_id, int)<CR>
            \..<CR>
            \string(firstname, 100)<CR>
            \string(lastname, 100)<CR>
            \string(gender, 1)<CR>
            \}<CR>
            \<CR>
            \table(mdc.Contact) {<CR>
            \f(**source_id**, **int**)<CR>
            \f(master_id, int)<CR>
            \..<CR>
            \f(//party_master_id//, //int//)<CR>
            \f(type, int)<CR>
            \string(value, 100)<CR>
            \}<CR>
            \<CR>
            \table(mdc.Document) {<CR>
            \f(**source_id**, **int**)<CR>
            \f(master_id, int)<CR>
            \..<CR>
            \f(//party_master_id//, //int//)<CR>
            \string(type, 2)<CR>
            \string(number, 100)<CR>
            \}<CR>
            \<CR>
            \table(mdc.Address) {<CR>
            \f(**source_id**, **int**)<CR>
            \f(master_id, int)<CR>
            \..<CR>
            \f(//party_master_id//, //int//)<CR>
            \string(country, 3)<CR>
            \string(city, 50)<CR>
            \string(street, 100)<CR>
            \}<CR>
            \<CR>
            \mdc.Party \"1\" --{ \"0..*\" mdc.Address: Party has\\\\naddresses<CR>
            \mdc.Party \"1\" --{ \"0..*\" mdc.Document: Party has\\\\ndocuments<CR>
            \mdc.Party \"1\" --{ \"0..*\" mdc.Contact: Party has\\\\ncontacts<CR>
            \<CR>
            \....
            \<Up>
            \<C-R>=Eatchar('\s')<CR>

