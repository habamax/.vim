let s:request_state = {}
let s:CRLF = "\r\n"

func! http#GET( host, port, uri, query_string, headers )
    let uri = a:uri
    if a:query_string != ''
        let uri .= '?' . a:query_string
    endif
    return s:http( 'GET', a:host, a:port, uri, a:headers, v:none )
endfunc

func! http#POST( host, port, uri, headers, data )
    return s:http( 'POST', a:host, a:port, a:uri, a:headers, a:data )
endfunc

func! s:OnData( channel, msg )
    let id =  ch_info( a:channel ).id
    let s:request_state[ id ].data .= a:msg
endfunc

func! s:OnClose( channel )
    let id = ch_info( a:channel ).id
    let data = s:request_state[ id ].data
    unlet s:request_state[ id ]
    let bounary = match( data, s:CRLF . s:CRLF )
    if bounary < 0
        " call s:Reject( id, "Invalid message received" )
        return
    endif

    let header = data[ 0:(bounary - 1) ]
    let body = data[ bounary + 2*len( s:CRLF ): ]

    let headers = split( header, s:CRLF )
    let status_line = headers[ 0 ]
    let headers = headers[ 1: ]

    let header_map = {}
    for header in headers
        let colon = match( header, ':' )
        let header_map[ tolower( header[ : colon-1 ] ) ]
                    \ = trim( header[ colon+1: ] )
    endfor

    let status_code = split( status_line )[ 1 ]

    " call s:Resolve( id, status_code, header_map, body )
endfunc


func! s:http( method, host, port, uri, headers, data )
    let ch = ch_open( a:host . ':' . a:port, #{
                \ mode: 'raw',
                \ callback: funcref( 's:OnData' ),
                \ close_cb: funcref( 's:OnClose' ),
                \ waittime: 100,
                \ } )

    if ch_status( ch ) != 'open'
        return v:none
    endif

    let id = ch_info( ch ).id
    let s:request_state[ id ] = #{ data: '', handle: ch }

    let a:headers[ 'Host' ] = a:host
    let a:headers[ 'Connection' ] = 'close'
    let a:headers[ 'Accept' ] = 'application/json'
    if a:data != v:none
        let a:headers[ 'Content-Length' ] = string( len( a:data ) )
    endif

    let msg = a:method . ' '. a:uri . ' HTTP/1.1' . s:CRLF
    for h in keys( a:headers )
        let msg .= h . ':' . a:headers[ h ] . s:CRLF
    endfor
    let msg .= s:CRLF
    if a:data != v:none
        let msg .= a:data
    endif
    call ch_sendraw( ch, msg )
    return id
endfunc
