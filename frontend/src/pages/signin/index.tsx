import React, { useRef } from 'react'
import Head from 'next/head'
import Link from 'next/link'
import { useMutation, gql } from '@apollo/client'
import { SubmitHandler, FormHandles } from '@unform/core'
import Input from '../../components/Input'
import Button from '../../components/Button'
import {
  Container,
  Form,
  SignUpLinkWrapper
} from '../../styles/pages/SignInStyles'
interface FormData {
  email: string
  password: string
}

const SIGN_IN = gql`
  mutation SignInMutation($email: String!, $password: String!) {
    signIn(email: $email, password: $password) {
      id
      email
      token
    }
  }
`

const SignIn: React.FC = () => {
  const formRef = useRef<FormHandles>(null)
  const [handleSubmitGql, { loading, error, data }] = useMutation(SIGN_IN)

  const handleSubmit: SubmitHandler<FormData> = data => {
    console.log(formRef, data)
    handleSubmitGql({
      variables: data
    })
  }

  if (loading) return <p>Loading...</p>
  if (error) return <p>Error :( </p>
  return (
    <Container>
      <Head>
        <title>Sign In</title>
      </Head>
      <Form ref={formRef} onSubmit={handleSubmit}>
        <Input name="email" label="E-mail" type="email" />
        <Input name="password" label="Password" type="password" />
        <Button type="submit">Sign In</Button>
      </Form>
      <SignUpLinkWrapper>
        <Link href="/signup">Create account</Link>
      </SignUpLinkWrapper>

      <p>{data && data.signIn.email}</p>
      <p>{data && data.signIn.id}</p>
      <p>{data && data.signIn.token}</p>
    </Container>
  )
}

export default SignIn
