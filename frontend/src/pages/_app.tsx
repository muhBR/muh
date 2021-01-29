import React from 'react'
import { AppProps } from 'next/app'
import GlobalStyle from '../styles/global'
import { ApolloProvider } from '@apollo/client'
import { ThemeProvider } from 'styled-components'
import theme from '../styles/theme'
import { useApollo } from '../services/apollo'

const Muh: React.FC<AppProps> = ({ Component, pageProps }) => {
  const apolloClient = useApollo(pageProps.initialApolloState)

  return (
    <ApolloProvider client={apolloClient}>
      <ThemeProvider theme={theme}>
        <Component {...pageProps} />
        <GlobalStyle />
      </ThemeProvider>
    </ApolloProvider>
  )
}

export default Muh
