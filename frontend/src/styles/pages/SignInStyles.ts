import styled from 'styled-components'
import { Form as UnformForm } from '@unform/web'

export const Container = styled.div`
  margin: 0 auto;
  max-width: 330px;
  padding: 40px 0;
  width: 100%;
`

export const Form = styled(UnformForm)`
  align-items: stretch;
  display: flex;
  flex-direction: column;
`

export const SignUpLinkWrapper = styled.div`
  display: flex;
  justify-content: center;
  margin-top: 16px;
  width: 100%;
`
