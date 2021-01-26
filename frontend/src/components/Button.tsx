import React from 'react'
import { ButtonStyled } from '../styles/components/ButtonStyles'

type ButtonProps = React.ButtonHTMLAttributes<HTMLButtonElement>

const Button: React.FC<ButtonProps> = ({ children, ...rest }) => {
  return <ButtonStyled {...rest}>{children}</ButtonStyled>
}

export default Button
